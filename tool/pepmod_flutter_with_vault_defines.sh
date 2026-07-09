#!/usr/bin/env bash
set -euo pipefail
set +x

usage() {
  cat >&2 <<'EOF'
Usage:
  tool/pepmod_flutter_with_vault_defines.sh build ipa --release
  tool/pepmod_flutter_with_vault_defines.sh build appbundle --release
  tool/pepmod_flutter_with_vault_defines.sh run -d <SIM_UDID>

Creates a temporary --dart-define-from-file outside the repo from mc-vault,
runs Flutter with it, then deletes the file. Secret values are never printed.

Optional service-label overrides:
  PEPMOD_APPREFER_KEY_SERVICE
  PEPMOD_GLEAP_TOKEN_SERVICE
  PEPMOD_SUPERWALL_IOS_KEY_SERVICE
  PEPMOD_SUPERWALL_ANDROID_KEY_SERVICE
EOF
}

if [[ $# -eq 0 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 64
fi

case "${1:-}" in
  build|run) ;;
  *)
    echo "error: first argument must be a Flutter 'build' or 'run' subcommand." >&2
    usage
    exit 64
    ;;
esac

if [[ ! -x /usr/bin/security ]]; then
  echo "error: macOS security tool not found; cannot read mc-vault." >&2
  exit 69
fi

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter is not on PATH." >&2
  exit 69
fi

defines_file="$(mktemp "${TMPDIR:-/tmp}/pepmod-dart-defines.XXXXXX")"
chmod 600 "$defines_file"

cleanup() {
  rm -f "$defines_file"
}
trap cleanup EXIT

PEPMOD_APPREFER_KEY_SERVICE="${PEPMOD_APPREFER_KEY_SERVICE:-peptideos-apprefer-api-key}" \
PEPMOD_GLEAP_TOKEN_SERVICE="${PEPMOD_GLEAP_TOKEN_SERVICE:-peptideos-gleap-sdk-token}" \
PEPMOD_SUPERWALL_IOS_KEY_SERVICE="${PEPMOD_SUPERWALL_IOS_KEY_SERVICE:-pepmod-superwall-ios-api-key}" \
PEPMOD_SUPERWALL_ANDROID_KEY_SERVICE="${PEPMOD_SUPERWALL_ANDROID_KEY_SERVICE:-pepmod-superwall-android-api-key}" \
python3 - "$defines_file" <<'PY'
import json
import os
import subprocess
import sys

path = sys.argv[1]

entries = {}
missing = []

secrets = [
    ("APPREFER_API_KEY", os.environ["PEPMOD_APPREFER_KEY_SERVICE"], True),
    ("GLEAP_SDK_TOKEN", os.environ["PEPMOD_GLEAP_TOKEN_SERVICE"], False),
    ("SUPERWALL_IOS_API_KEY", os.environ["PEPMOD_SUPERWALL_IOS_KEY_SERVICE"], True),
    (
        "SUPERWALL_ANDROID_API_KEY",
        os.environ["PEPMOD_SUPERWALL_ANDROID_KEY_SERVICE"],
        True,
    ),
]

for define_name, service_name, required in secrets:
    result = subprocess.run(
        ["/usr/bin/security", "find-generic-password", "-s", service_name, "-w"],
        stdout=subprocess.PIPE,
        stderr=subprocess.DEVNULL,
        text=True,
        check=False,
    )
    value = result.stdout.rstrip("\n") if result.returncode == 0 else ""
    if not value:
        if required:
            missing.append(f"{define_name} ({service_name})")
        continue
    entries[define_name] = value

if missing:
    print(
        "error: missing required mc-vault secrets: " + ", ".join(missing),
        file=sys.stderr,
    )
    sys.exit(66)

with open(path, "w", encoding="utf-8") as handle:
    json.dump(entries, handle, separators=(",", ":"))
os.chmod(path, 0o600)

print(
    "Prepared dart-define file with keys: " + ", ".join(sorted(entries.keys())),
    file=sys.stderr,
)
PY

flutter "$@" --dart-define-from-file="$defines_file"
