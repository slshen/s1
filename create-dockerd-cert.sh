#!/bin/sh

set -e

if [ "$#" -lt 2 ]; then
  echo "usage: $0 server-name ip-addresses ..."
  exit 2
fi
name=$1
shift
ips=IP:127.0.0.1

for ip in "$*"; do
  ips=$ips,IP:$ip
done

dest=/var/local/docker

mkdir -p $dest
chmod a+rx $dest

cd $dest

if [ ! -f ca.pem ]; then
  echo "---- CREATING SIGNING CERT ----"
  openssl genrsa -out ca-key.pem 2048
  openssl req -new -x509 -days 1095 -key ca-key.pem -sha256 -out ca.pem -subj "/CN=pprentice.com"
fi

chmod a+r ca.pem
chmod og-r ca-key.pem

mkdir -p dockerd-cert
chmod og-rx dockerd-cert
cd dockerd-cert

if [ ! -f cert.pem ]; then
  echo "--- CREATING DOCKERD CERT ---"
  openssl genrsa -out key.pem 2048
  openssl req -subj "/CN=$name" -sha256 -new -key key.pem -out cert.csr
  cat > extfile.cnf <<EOF
extendedKeyUsage = serverAuth
subjectAltName = DNS:$name,$ips
EOF
  openssl x509 -req -days 1095 -sha256 -in cert.csr -CA ../ca.pem -CAkey ../ca-key.pem \
    -CAcreateserial -out cert.pem -extfile extfile.cnf
fi
rm -f extfile.cnf cert.csr
chmod og-r *

mkdir -p ~/.docker
cd ~/.docker
ln -s $dest/ca.pem

