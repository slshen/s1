TERRAFORM_VERSION=0.11.11
TERRAFORM=$(shell ./get_terraform.sh $(TERRAFORM_VERSION))

modules=dnsproxy dhcp

default:
	echo $(TERRAFORM)

clean:
	rm -rf bin

do-%:
	for m in $(modules); do \
	  $(MAKE) -C $$m $(@:do-%=%); \
	done
