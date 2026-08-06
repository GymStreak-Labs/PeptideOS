# PepMod store localization

The `app-info` files are the reviewable source for localized App Store name,
subtitle, and privacy URL values. Keep names and subtitles within App Store
Connect's 30-character limit before syncing them through the GymStreak Labs
store account.

Store metadata must not promise prescribing, diagnosis, or recommended dosing.
Use tracking language such as protocols, logs, reminders, unit conversion, and
vial math. A metadata change does not authorize a binary upload or submission
for review.

The `play-listings` files are the equivalent checked-in source for Google Play
title, short description, full description, and privacy URL. They are review
artifacts only; checking them in does not authorize a Play Console mutation.

Versioned release notes live under `release-notes/app-store` and
`release-notes/google-play`. Each file maps the store's locale code to the exact
text intended for that release. Google Play release-note values must remain at
or below 500 characters and are passed directly to `gpc upload --notes-file`.
