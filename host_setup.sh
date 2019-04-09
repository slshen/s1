#!/bin/sh

echo http://dl-cdn.alpinelinux.org/alpine/v3.8/community >> /etc/apk/repositories

apk add git bind-tools docker make curl sudo emacs less openssl zip groff

user=sls

adduser $user
adduser $user wheel docker
cat > /etc/sudoers.d/wheel <<EOF
## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL
EOF

cat > /etc/resolv.conf <<EOF
nameserver 192.168.1.9
nameserver 1.1.1.1
EOF

cat > /etc/sysctl.d/local.conf <<EOF
vm.max_map_count=262144
EOF

./create-dockerd-cert.sh

cat > /etc/docker/daemon.json <<EOF
{
    "experimental": true
    "tls": true,
    "tlsverify": true,
    "tlscacert": "/var/local/docker/ca.pem",
    "tlscert": "/var/local/docker/dockerd-cert/cert.pem",
    "tlskey": "/var/local/docker/dockerd-cert/key.pem"
}
EOF

cat >> /etc/conf.d/docker <<EOF
DOCKER_OPTS="-H unix:///var/run/docker.sock -H tcp://127.0.0.1:2376 -H tcp://192.168.1.9:2376"
EOF

cat >> /etc/networking/interfaces <<EOF
auto ipv0
iface ipv0 inet manual
        pre-up ip link add ipv0 link eth0 type ipvlan mode bridge
        up ip addr add 192.168.1.160 dev ipv0
        up ip link set ipv0 up
        up ip route add 192.168.1.160/27 via 192.168.1.160
        post-down ip link del ipv0
EOF

# https://hicu.be/macvlan-vs-ipvlan

docker network create -d ipvlan --subnet 192.168.1.0/24 \
       --ip-range 192.168.1.160/27 --gateway 192.168.1.1 \
       -o ipvlan_mode=l2 net160 -o parent=eth0 \
       --aux-address="container_host=192.168.1.160"

