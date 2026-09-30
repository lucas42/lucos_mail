#!/bin/bash
set -e
set -m

if [ -z "$DOVECOT_USERS_BASE64" ]; then
  echo "DOVECOT_USERS_BASE64 is not set - refusing to start without SASL users" >&2
  exit 1
fi
echo "$DOVECOT_USERS_BASE64" | base64 -d > /etc/dovecot/users
if ! grep -q '^[^:#][^:]*:{' /etc/dovecot/users; then
  echo "DOVECOT_USERS_BASE64 contains no valid <address>:{scheme}hash lines" >&2
  exit 1
fi

newaliases
dovecot
postfix -v start-fg
