#!/bin/sh

echo http://dl-cdn.alpinelinux.org/alpine/v3.8/community >> /etc/apk/repositories

apk add git bind-tools docker make curl sudo emacs less

user=sls

adduser $user
adduser $user wheel docker
cat > /etc/sudoers.d/wheel <<EOF
## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

# so since we're going to be running dnsproxy in a docker container
# on this host we need to set dns manually to the bridge ip address
# otherwise host name lookups fail (results come from 172.17.0.1
# instead of the host's ip address)
cat > /etc/docker/daemon.json <<EOF
{
    "dns": [ "172.17.0.1" ] 
}
EOF

