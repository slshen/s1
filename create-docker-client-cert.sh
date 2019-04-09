#!/bin/sh

set -e

if [ "$#" -ne 1 ]; then
  echo "usage: $0 client-name"
  exit 2
fi
client=$1

dest=/var/local/docker/client-certs/$client
mkdir -p $dest
cd $dest

openssl genrsa -out key.pem 2048
openssl req -subj "/CN=$client" -new -key key.pem -out client.csr
cat > extfile.cnf <<EOF
extendedKeyUsage = clientAuth
EOF
openssl x509 -req -days 1095 -sha256 -in client.csr \
        -CA /var/local/docker/ca.pem -CAkey /var/local/docker/ca-key.pem \
        -CAcreateserial -out cert.pem -extfile extfile.cnf

rm client.csr extfile.cnf
ln -sf /var/local/docker/ca.pem

chgrp -R docker .
chmod -R o-rx .
chmod -R g+r .

if [ "$client" = "local" ]; then
  mkdir -p ~/.docker
  cd ~/.docker
  ln -sf $dest/ca.pem .
  ln -sf $dest/key.pem .
  ln -sf $dest/cert.pem .
fi
