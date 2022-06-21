FROM alpine:latest

RUN apk --update add postfix dovecot bash

WORKDIR /etc/postfix
COPY config .
COPY dovecot.conf /etc/dovecot/conf.d/10-master.conf

EXPOSE 25

CMD ./startup.sh