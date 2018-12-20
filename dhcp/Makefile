VERSION=v0
IMAGE=dhcp
IMAGE_TAG=$(IMAGE):$(VERSION)

compile: Dockerfile dhcpd.conf
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=net160 --restart=unless-stopped --init -d \
	  --name dhcp \
	$(IMAGE)

remove:
	docker rm --force dhcp || true

restart: remove start


