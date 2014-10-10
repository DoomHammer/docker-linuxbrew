# Build the Linuxbrew Docker images
# Written by Shaun Jackman

# The Docker Hub repository
r=sjackman

all: $r/linuxbrew

clean:
	rm -f $r/linuxbrew $r/linuxbrew-core

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

# Image dependencies
$r/linuxbrew-core: $r/ubuntu
$r/linuxbrew: $r/linuxbrew-core

$r/stamp:
	mkdir -p $r
	touch $@

$r/%: %/Dockerfile $r/stamp
	docker build -t $r/$* $*
	docker images --no-trunc |awk '$$1=="$@" {print $$3}' >$@