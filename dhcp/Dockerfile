FROM alpine:3.8
RUN apk add dhcp
COPY dhcpd.conf resolv.conf /etc/
RUN touch /var/lib/dhcp/dhcpd.leases
CMD [ "/usr/sbin/dhcpd", "-4", "-f", "-d" ]

