VERSION=v0
IMAGE=samba
IMAGE_TAG=$(IMAGE):$(VERSION)

.PHONY: users.sh

compile: Dockerfile smb.conf users.sh
	docker build -t $(IMAGE) -t $(IMAGE_TAG) .

users.sh:
	aws s3 sync s3://slshen-us-west-2/ops/s1/samba/users.sh .

push-users:
	aws s3 cp users.sh s3://slshen-us-west-2/ops/s1/samba/users.sh

start:
	docker run \
	  --network=net160 --ip="192.168.1.169" --init -d \
	  --name samba -v /home:/home $(IMAGE)

# --restart=unless-stopped

remove:
	docker rm --force samba || true

restart: remove start
