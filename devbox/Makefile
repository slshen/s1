VERSION=v0
IMAGE=devbox
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: s1-only volume

image: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start: s1-only volume
	docker run \
	  --network=net160 --ip=192.168.1.170 --restart=unless-stopped --init -d \
	  --name devbox --hostname devbox \
	  --dns-search pprentice.com --dns-opt ndots:1 --dns 192.168.1.165 \
	  -v devbox:/home -v /var/run/docker.sock:/var/run/docker.sock \
	  $(IMAGE)

volume: s1-only
	docker volume create devbox

remove: s1-only
	docker rm --force devbox || true

restart: remove start

s1-only:
	test $$(hostname) = "s1"
