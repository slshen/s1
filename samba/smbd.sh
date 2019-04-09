#!/bin/sh

# samba will run in the foreground buts exits when stdin is closed
# (e.g. docker detached mode)

set -e

rm -f /var/run/samba/smbd.pid
/usr/sbin/smbd $*
while [ ! -f /var/run/samba/smbd.pid ]; do
  sleep 5
done
pid=$(cat var/run/samba/smbd.pid)
echo "smbd has started with pid $pid"
while [ -d /proc/$pid ]; do
  sleep 10
done
echo "smbd has exited"
ps -ef
sleep 10


