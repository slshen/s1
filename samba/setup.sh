#!/bin/sh

set -e

function u () {
  user=$1 pw="$2" uid="$3" gid="$4"
  addgroup -g $gid $user
  adduser -D -u $uid -G $user -s /sbin/nologin $user
  echo "$user:$pw" | chpasswd
  smbpasswd -a $user <<EOF
$pw
$pw
EOF
  echo "--- ADDED SMB USER $user"
}

ln -s /dev/stdout /var/log/samba/log.smbd

. /users.sh
