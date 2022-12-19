VERSION=v0
IMAGE=rtl_tcp
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: s1-only volume

image: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start: s1-only volume
	docker run \
	  --network=net160 --ip 192.168.1.172 --restart=unless-stopped --init -d \
	  --name rtl_tcp --hostname rtl_tcp \
	  -v /dev/bus/usb:/dev/bus/usb --device-cgroup-rule='c 189:* rmw' \
	  $(IMAGE)

remove: s1-only
	docker rm --force rtl_tcp || true

restart: remove start

s1-only:
	test $$(hostname) = "s1"
