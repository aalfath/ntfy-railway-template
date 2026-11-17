# Changelog

Each entry is one version of this template. Breaking changes are listed first.

## 2026-11-17: ntfy v2.38.1 (security release)

- No breaking changes. Your messages, users and attachments on the `/var/lib/ntfy` volume are kept.
- ntfy [v2.38.1](https://github.com/binwiederhier/ntfy/releases/tag/v2.38.1) is a security release: it hardens message templating against denial-of-service attacks, buffers S3 attachment uploads in small chunks, and adds timeouts to web push deliveries.
- Image: `binwiederhier/ntfy:v2.38.1@sha256:038da2be5e668fee6d36a62884eea48975e1b71c29a56964e5298c1b9165a573`.

## 2026-11-16: Deploy on Railway button

- README starts with the Deploy on Railway button for the published template `ntfy-2`. No change to the app or its settings.

## 2026-11-16: ntfy v2.38.0

- First version of the template: `binwiederhier/ntfy:v2.38.0` pinned by digest
  (`sha256:771309aecfce18d8fe2bfb8069994ddd6be6ca6ccdd7badace3d791a0045ff0d`).
- SQLite message cache, user database and attachments on a Railway volume at `/var/lib/ntfy`.
- Login required by default (`NTFY_AUTH_DEFAULT_ACCESS=deny-all`), with an admin user
  provisioned from `NTFY_ADMIN_USER` and a generated `NTFY_ADMIN_PASSWORD`.
- Health check on `/v1/health`.
