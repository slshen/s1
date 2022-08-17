FROM alpine:3.9

RUN apk update && \
    apk add lighttpd

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]