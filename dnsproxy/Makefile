VERSION=v0
IMAGE=dnsproxy
IMAGE_TAG=$(IMAGE):$(VERSION)

compile: Dockerfile
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start:
	docker run \
	  --network=host -p 53:53/udp -p 53:53/tcp \
	  --restart=unless-stopped \
	  --init \
	  -d \
	 --name dnsproxy \
	$(IMAGE)

remove:
	docker rm dnsproxy || true

restart: remove start


