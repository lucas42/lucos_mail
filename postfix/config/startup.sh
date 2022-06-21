#!/bin/bash
set -e
set -m

newaliases
dovecot
postfix -v start-fg