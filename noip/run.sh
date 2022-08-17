#!/bin/sh

password=$(cat /password.txt)

while true; do
  dns_addr=$(host slshen.hopto.org 1.1.1.1 | grep "slshen.hopto.org has address " | awk '{ print $NF }')
  addr=$(curl -s ifconfig.me)
  echo "dns_adr = $dns_addr addr = $addr"
  if [ "$addr" != "" -a "$dns_addr" != "$addr" ]; then
    echo "internet address is $addr"
    echo "dns address is $dns_addr"
    curl -u sls@metopic.com:${password} \
      "https://dynupdate.no-ip.com/nic/update?hostname=slshen.hopto.org&myip=${addr}"
  fi
  sleep 600
done
