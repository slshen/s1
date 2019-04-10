VERSION=1.20.2
IMAGE=portainer/portainer
IMAGE_TAG=$(IMAGE):$(VERSION)

start:
	docker run \
	  --init -d -p 9000:9000 \
	  --restart=unless-stopped \
	  --name portainer \
	  -v /var/local/portainer:/data \
	  -v /var/run/docker.sock:/var/run/docker.sock \
	  $(IMAGE_TAG)

remove:
	docker rm --force portainer || true

restart: remove start
