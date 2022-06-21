# LucOS Mail
An SMTP server for sending emails from the lucOS ecosystem

## Dependencies
* docker-compose
* [lucos_router](https://github.com/lucas42/lucos_router) running in the same docker environment - its TLS cert volume is used here, so the domain must have been included there too.

## Container setup

* Image: **lucos_mail_smtp** - runs a postfix mail server
* Volume: **lucos_router_letsencrypt** - used for TLS cert for the mail server
* Image: **lucos_mail_docs** - A static website with some documentation for the mail server