VERSION=v0
IMAGE=dnsproxy
IMAGE_TAG=$(IMAGE):$(VERSION)

compile: Dockerfile dnscrypt-proxy.toml cloaking-rules.txt
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=net160 --ip=192.168.1.165 --restart=unless-stopped --init -d \
	  --name dnsproxy $(IMAGE)

remove:
	docker rm --force dnsproxy || true

restart: remove start


