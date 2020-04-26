FROM alpine:3.11

RUN apk update && \
  apk add curl bind-tools

COPY password.txt /
COPY run.sh /

ENTRYPOINT [ "/run.sh" ]
