#!/bin/sh

echo http://dl-cdn.alpinelinux.org/alpine/v3.8/community >> /etc/apk/repositories

apk add git bind-tools docker make curl sudo emacs

user=sls

adduser $user
adduser $user wheel docker
cat > /etc/sudoers.d/wheel <<EOF
## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL
EOF


