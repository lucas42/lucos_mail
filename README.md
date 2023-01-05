# LucOS Mail
An SMTP server for sending emails from the lucOS ecosystem

## Dependencies
* docker-compose
* [lucos_router](https://github.com/lucas42/lucos_router) running in the same docker environment - its TLS cert volume is used here, so the domain must have been included there too.

## Container setup

* Image: **lucos_mail_smtp** - runs a postfix mail server
* Volume: **lucos_router_letsencrypt** - used for TLS cert for the mail server
* Image: **lucos_mail_docs** - A static website with some documentation for the mail server

## Adding new users

Ideally, each email-sending service should have its own user.  To add one, edit the `postfix/users` file.  On a new line add:
```
<address>:<password_hash>
```
Where `<address>` is the email address the service will send emails from and `<password_hash>` is the output of `docker exec -it lucos_mail_smtp doveadm pw -s SHA512-CRYPT`.  
Overall, it should look something like:
```
test-send@l42.eu:{SHA512-CRYPT}$6$vQuXxgstiLqmzuZn$MUWOy7vHRbDf/WXcMH5KbxEHrBmt6/kytDfbTQYlDhF/zfK/uKZ.QCMo.TwF6cMkpOPy0KDX.XnIOXWEdl2nm/
```

## Rotating a user's password

Run `docker exec -it lucos_mail_smtp doveadm pw -s SHA512-CRYPT` and enter a new password to get the new hash.
Edit the `postfix/users` file, looking for the row corresponding to the user being rotated.  Replace everything after the colon with the new hash.