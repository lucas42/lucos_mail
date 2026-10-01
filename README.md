# LucOS Mail
An SMTP server for sending emails from the lucOS ecosystem

## Dependencies
* docker compose
* [lucos_router](https://github.com/lucas42/lucos_router) running in the same docker environment - its TLS cert volume is used here, so the domain must have been included there too.

## Container setup

* Image: **lucos_mail_smtp** - runs a postfix mail server
* Volume: **lucos_router_letsencrypt** - used for TLS cert for the mail server
* Image: **lucos_mail_docs** - A static website with some documentation for the mail server

## SMTP users

SMTP AUTH users live in the `DOVECOT_USERS` environment variable (stored in lucos_creds, never committed to git).  Its value is a Dovecot passwd-file, one `<address>:<password_hash>` line per user, where `<address>` is the email address the service sends from and `<password_hash>` is the output of `docker exec -it lucos_mail_smtp doveadm pw -s SHA512-CRYPT`.  For example:
```
test-send@l42.eu:{SHA512-CRYPT}$6$vQuXxgstiLqmzuZn$MUWOy7vHRbDf/WXcMH5KbxEHrBmt6/kytDfbTQYlDhF/zfK/uKZ.QCMo.TwF6cMkpOPy0KDX.XnIOXWEdl2nm/
```
**Write every `$` as `$$` when storing the value in lucos_creds.**  Docker Compose treats `$` in a `.env` value as variable interpolation, so an unescaped hash arrives with its salt missing.  `startup.sh` writes the value to `/etc/dovecot/users` at container start, and exits without starting Dovecot if the variable is empty or malformed (including a hash that lost its `$` signs).

Ideally, each email-sending service should have its own user.

### Adding a user or rotating a password

1. Generate a hash with `doveadm pw -s SHA512-CRYPT` (as above).
2. Edit the lucos_creds `DOVECOT_USERS` value: add a line for the new user, or replace everything after the colon for the user being rotated.  Remember to double each `$`.
3. Redeploy.
