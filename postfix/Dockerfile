FROM alpine:3.24.2
ARG VERSION
ENV VERSION=$VERSION

RUN apk --update add postfix dovecot bash busybox-extras

WORKDIR /etc/postfix
COPY config .

RUN rm -rf /etc/dovecot/conf.d
COPY dovecot.conf /etc/dovecot/

EXPOSE 25

CMD ./startup.sh