FROM alpine:3.16

RUN apk update && apk add rtl-sdr

ENTRYPOINT [ "/usr/bin/rtl_tcp", "-a", "192.168.1.172" ]
