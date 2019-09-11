#!/bin/bash

mkdir /run/sshd
/usr/sbin/sshd -p 222

USERS=slshen

for user in $USERS; do
  if ! id foo 2> /dev/null; then
    adduser --disabled-password $user < /dev/null
    adduser $user docker
    runuser -u $user -- mkdir /home/$user/.ssh
  fi
done

while true; do
  for user in $USERS; do
    keys=$(curl -s -L https://api.github.com/users/$user/keys)
    runuser -u $user -- cp /dev/null /home/$user/.ssh/authorized_keys
    for n in $(seq 1 $(echo $keys | jq 'length')); do
      echo $keys | jq -r ".[$((n - 1))].key" | \
        runuser -u $user -- bash -c "cat >> /home/$user/.ssh/authorized_keys"
    done
  done
  sleep $((3600 + RANDOM / 100))
done
