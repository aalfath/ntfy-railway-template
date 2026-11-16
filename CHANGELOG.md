# Changelog

Each entry is one version of this template. Breaking changes are listed first.

## 2026-11-16: ntfy v2.38.0

- First version of the template: `binwiederhier/ntfy:v2.38.0` pinned by digest
  (`sha256:771309aecfce18d8fe2bfb8069994ddd6be6ca6ccdd7badace3d791a0045ff0d`).
- SQLite message cache, user database and attachments on a Railway volume at `/var/lib/ntfy`.
- Login required by default (`NTFY_AUTH_DEFAULT_ACCESS=deny-all`), with an admin user
  provisioned from `NTFY_ADMIN_USER` and a generated `NTFY_ADMIN_PASSWORD`.
- Health check on `/v1/health`.
