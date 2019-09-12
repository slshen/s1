FROM alpine:3.8
EXPOSE 53/tcp 53/udp
RUN apk add -X http://dl-cdn.alpinelinux.org/alpine/edge/testing minisign && \
  apk add ca-certificates
WORKDIR /app
COPY dnscrypt-proxy.tar.gz.minisig ./
RUN wget -O dnscrypt-proxy.tar.gz https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.27/dnscrypt-proxy-linux_x86_64-2.0.27.tar.gz && \
  minisign -Vm dnscrypt-proxy.tar.gz -P RWTk1xXqcTODeYttYMCMLo0YJHaFEHn7a3akqHlb/7QvIQXHVPxKbjB5 && \
  tar zxf dnscrypt-proxy.tar.gz && \
  cp linux-x86_64/dnscrypt-proxy . && \
  rm -rf linux-x86_64 dnscrypt-proxy.tar.gz*
COPY dnscrypt-proxy.toml cloaking-rules.txt blacklist.txt ./
# add .lan as well for local domain names as a windows workaround
RUN sed -i -e "p s/.pprentice.com/.lan/" cloaking-rules.txt
CMD [ "/app/dnscrypt-proxy" ]
