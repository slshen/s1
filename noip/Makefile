VERSION=v0
IMAGE=noip
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: s1-only

compile: Dockerfile password.txt
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

start: s1-only 
	docker run \
	  --restart=unless-stopped --init -d \
	  --name noip \
	  --dns 8.8.8.8 \
	  --log-driver json-ile \
	  $(IMAGE)

password.txt:
	if [ ! -f password.txt ]; then
		aws s3 cp s3://slshen-us-west-2/ops/s1/noip/password.txt .
	fi

remove: s1-only
	docker rm --force devbox || true

restart: remove start

s1-only:
	test $$(hostname) = "s1" || test $$(hostname) = "devbox"
