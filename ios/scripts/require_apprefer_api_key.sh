#!/bin/sh
set -eu

if [ "${CONFIGURATION:-}" != "Release" ]; then
  exit 0
fi

if [ -z "${DART_DEFINES:-}" ]; then
  echo "error: Release builds require --dart-define=APPREFER_API_KEY." >&2
  exit 1
fi

decode_define() {
  printf '%s' "$1" | /usr/bin/base64 --decode 2>/dev/null ||
    printf '%s' "$1" | /usr/bin/base64 -D 2>/dev/null ||
    true
}

has_apprefer_api_key=0
old_ifs=$IFS
IFS=,
for encoded_define in $DART_DEFINES; do
  decoded_define="$(decode_define "$encoded_define")"
  case "$decoded_define" in
    APPREFER_API_KEY=TODO_* | APPREFER_API_KEY=)
      has_apprefer_api_key=0
      break
      ;;
    APPREFER_API_KEY=*)
      has_apprefer_api_key=1
      ;;
  esac
done
IFS=$old_ifs

if [ "$has_apprefer_api_key" != "1" ]; then
  echo "error: Release builds require --dart-define=APPREFER_API_KEY with a non-placeholder value." >&2
  exit 1
fi
