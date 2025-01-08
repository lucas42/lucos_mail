FROM alpine:3.21.1

RUN apk --update add postfix dovecot bash

WORKDIR /etc/postfix
COPY config .

RUN rm -rf /etc/dovecot/conf.d
COPY dovecot.conf /etc/dovecot/
COPY users /etc/dovecot/users

EXPOSE 25

CMD ./startup.sh