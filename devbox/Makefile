VERSION=v0
IMAGE=devbox
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: s1-only volume

compile: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start: s1-only volume
	docker run \
	  --network=net160 --ip=192.168.1.170 --restart=unless-stopped --init -d \
	  --name devbox --hostname devbox -v devbox:/home -v /var/run/docker.sock:/var/run/docker.sock \
	  $(IMAGE)

volume: s1-only
	docker volume create devbox

remove: s1-only
	docker rm --force devbox || true

restart: remove start

s1-only:
	test $$(hostname) = "s1"
