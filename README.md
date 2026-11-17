[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/ntfy-2?utm_medium=integration&utm_source=button&utm_campaign=ntfy)

# ntfy on Railway

A Railway template for [ntfy](https://ntfy.sh), the open-source push notification server: send notifications to your phone or desktop with a simple HTTP `PUT`/`POST`.

This repo builds the official image `binwiederhier/ntfy:v2.38.1`, pinned by digest, with a small start script (`start.sh`) that applies Railway-friendly defaults.

## What the template deploys

One service, **ntfy**, built from this repo:

- listens on Railway's `PORT` (8080) behind a public Railway domain;
- keeps the SQLite message cache, the user database and attachments on a volume at `/var/lib/ntfy`;
- requires login for every topic (`NTFY_AUTH_DEFAULT_ACCESS=deny-all`);
- provisions an admin user from `NTFY_ADMIN_USER` and `NTFY_ADMIN_PASSWORD` on every start;
- answers its health check on `/v1/health`.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `NTFY_ADMIN_USER` | `admin` | Admin username |
| `NTFY_ADMIN_PASSWORD` | generated secret | Admin password. It's the source of truth: change it and redeploy to change the password |
| `NTFY_BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Public URL, used for attachment links and the web app |
| `PORT` | `8080` | Port ntfy listens on |

Any other [ntfy setting](https://docs.ntfy.sh/config/) can be set as an `NTFY_*` variable, for example:

- `NTFY_AUTH_DEFAULT_ACCESS=read-only` to let anyone subscribe without logging in;
- `NTFY_AUTH_USERS`, `NTFY_AUTH_ACCESS`, `NTFY_AUTH_TOKENS` to provision more users, ACLs and tokens (the admin user is added to `NTFY_AUTH_USERS` automatically);
- `NTFY_SMTP_SENDER_*` for email notifications, `NTFY_WEB_PUSH_*` for browser push;
- `NTFY_UPSTREAM_BASE_URL` (default `https://ntfy.sh`, needed for instant notifications in the iOS app; set it empty to turn it off).

Your Railway service shell also has the `ntfy user` and `ntfy access` commands.

## Updates

The image is pinned in `Dockerfile`. Each new ntfy version is a pull request that bumps the tag and digest and adds a `CHANGELOG.md` entry. When it's merged to `main`, Railway shows deployers of this template an "update available" notice, and they choose when to apply it. Read `CHANGELOG.md` before you apply an update.

## License

The template files in this repo are MIT licensed. ntfy itself is dual-licensed under Apache 2.0 and GPLv2.
