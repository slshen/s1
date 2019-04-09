FROM alpine:3.8
RUN apk add samba
COPY smb.conf /etc/samba/
COPY smbd.sh setup.sh users.sh /
RUN /setup.sh
CMD [ "/smbd.sh", "--no-process-group", "-d", "3" ]
