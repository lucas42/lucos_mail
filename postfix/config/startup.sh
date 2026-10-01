#!/bin/bash
set -e
set -m

if [ -z "$DOVECOT_USERS" ]; then
  echo "DOVECOT_USERS is not set - refusing to start without SASL users" >&2
  exit 1
fi
printf '%s\n' "$DOVECOT_USERS" > /etc/dovecot/users
# Compose treats $ in a .env value as interpolation, so unescaped *CRYPT hashes arrive truncated: reject them rather than start with logins that can never succeed.
if ! grep -Eq '^[^:#]+:\{[A-Za-z0-9-]+\}[^[:space:]]+$' /etc/dovecot/users \
  || grep -Ev '^[^:#]+:\{[A-Za-z0-9-]+\}[^[:space:]]+$' /etc/dovecot/users | grep -q . \
  || grep 'CRYPT}' /etc/dovecot/users | grep -Ev '\}\$[0-9a-z]+\$([^$]+\$)+[^$]+$' | grep -q .; then
  echo 'DOVECOT_USERS is malformed: want one <address>:{scheme}hash per line, with CRYPT hashes in $id$salt$hash form (write each $ as $$ in lucos_creds)' >&2
  exit 1
fi

newaliases
dovecot
postfix -v start-fg
