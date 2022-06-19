# lucos_mail_smtp
An SMTP server for sending emails from the lucOS ecosystem

## Dependencies
* docker-compose
* lucos_router running in the same docker environment - its TLS cert volume is used here, so the domain must have been included there too.