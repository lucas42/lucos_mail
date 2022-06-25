FROM alpine:latest

RUN apk --update add postfix dovecot bash

WORKDIR /etc/postfix
COPY config .
COPY dovecot.conf /etc/dovecot/conf.d/10-master.conf
COPY users /etc/dovecot/users

EXPOSE 25

CMD ./startup.sh