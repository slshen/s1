#!/bin/sh

set -e

function u () {
  user=$1 pw="$2"
  adduser -D $user
  echo "$user:$pw" | chpasswd
  smbpasswd -a $user <<EOF
$pw
$pw
EOF
  echo "--- ADDED SMB USER $user"
}

ln -s /dev/stdout /var/log/samba/log.smbd

. /users.sh
