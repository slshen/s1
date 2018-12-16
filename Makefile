modules=dnsproxy

do-%:
	for m in $(modules); do \
	  $(MAKE) -C $$m $(@:do-%=%); \
	done
