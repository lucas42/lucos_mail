FROM alpine:latest

RUN apk --update add postfix dovecot bash

WORKDIR /etc/postfix
COPY config .

RUN rm -rf /etc/dovecot/conf.d
COPY dovecot.conf /etc/dovecot/
COPY users /etc/dovecot/users

EXPOSE 25

CMD ./startup.sh