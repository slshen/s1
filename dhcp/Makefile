VERSION=v0
IMAGE=dhcp
IMAGE_TAG=$(IMAGE):$(VERSION)

compile: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=host --restart=unless-stopped --init -d \
	  --name dhcp \
	$(IMAGE)

remove:
	docker rm --force dhcp || true

restart: remove start


