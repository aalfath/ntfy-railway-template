#!/bin/sh
# Start ntfy with Railway-friendly defaults. Every NTFY_* setting below can be
# overridden with a service variable of the same name.
set -eu

DATA_DIR="${NTFY_DATA_DIR:-/var/lib/ntfy}"
mkdir -p "$DATA_DIR/attachments"

export NTFY_LISTEN_HTTP="${NTFY_LISTEN_HTTP:-:${PORT:-8080}}"
export NTFY_CACHE_FILE="${NTFY_CACHE_FILE:-$DATA_DIR/cache.db}"
export NTFY_AUTH_FILE="${NTFY_AUTH_FILE:-$DATA_DIR/user.db}"
export NTFY_ATTACHMENT_CACHE_DIR="${NTFY_ATTACHMENT_CACHE_DIR:-$DATA_DIR/attachments}"
# Nobody can read or write topics without logging in, unless you change this.
export NTFY_AUTH_DEFAULT_ACCESS="${NTFY_AUTH_DEFAULT_ACCESS:-deny-all}"
# Railway's edge proxy sets X-Forwarded-For.
export NTFY_BEHIND_PROXY="${NTFY_BEHIND_PROXY:-true}"
export NTFY_ENABLE_LOGIN="${NTFY_ENABLE_LOGIN:-true}"
# Needed for instant notifications in the iOS app. Set it to an empty value to turn it off.
export NTFY_UPSTREAM_BASE_URL="${NTFY_UPSTREAM_BASE_URL-https://ntfy.sh}"
[ -n "$NTFY_UPSTREAM_BASE_URL" ] || unset NTFY_UPSTREAM_BASE_URL
[ -n "${NTFY_BASE_URL:-}" ] || unset NTFY_BASE_URL

# Provision the admin user from NTFY_ADMIN_USER / NTFY_ADMIN_PASSWORD on every start.
# The password variable is the source of truth: change it and redeploy to change the password.
if [ -n "${NTFY_ADMIN_PASSWORD:-}" ]; then
  admin_user="${NTFY_ADMIN_USER:-admin}"
  admin_hash="$(printf '%s\n%s\n' "$NTFY_ADMIN_PASSWORD" "$NTFY_ADMIN_PASSWORD" | ntfy user hash 2>/dev/null)"
  case "$admin_hash" in
    '$2'*) ;;
    *) echo "railway-start: could not hash NTFY_ADMIN_PASSWORD" >&2; exit 1 ;;
  esac
  admin_entry="$admin_user:$admin_hash:admin"
  export NTFY_AUTH_USERS="${NTFY_AUTH_USERS:+$NTFY_AUTH_USERS,}$admin_entry"
  echo "railway-start: admin user '$admin_user' provisioned"
else
  echo "railway-start: NTFY_ADMIN_PASSWORD is empty, no admin user provisioned" >&2
fi

exec ntfy serve "$@"
