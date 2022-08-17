VERSION=v0
IMAGE=www
IMAGE_TAG=$(IMAGE):$(VERSION)

image: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=net160 --ip="192.168.1.171" --init -d \
	  --restart=unless-stopped \
	  --name www $(IMAGE)

remove:
	docker rm --force www || true

restart: remove start
