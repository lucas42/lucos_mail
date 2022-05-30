FROM alpine:latest

RUN apk --update add postfix

WORKDIR /etc/postfix
COPY config .

EXPOSE 25

CMD ./startup.sh