VERSION=v0
IMAGE=dnsproxy
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: s1-only

image: Dockerfile dnscrypt-proxy.toml cloaking-rules.txt
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start: s1-only
	docker run \
	  --network=net160 --ip=192.168.1.165 --restart=unless-stopped --init -d \
	  --log-driver=syslog \
      --log-opt syslog-address=tcp+tls://logs3.papertrailapp.com:48516 \
      --log-opt tag=dnsproxy \
	  --name dnsproxy $(IMAGE)

remove: s1-only
	docker rm --force dnsproxy || true

restart: remove start

s1-only:
	test $$(hostname) = "s1" -o $$(hostname) = "devbox"
