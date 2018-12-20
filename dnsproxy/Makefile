VERSION=v0
IMAGE=dnsproxy
IMAGE_TAG=$(IMAGE):$(VERSION)

compile: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=net160 --restart=unless-stopped --init -d \
	  --name dnsproxy $(IMAGE)

remove:
	docker rm --force dnsproxy || true

restart: remove start


