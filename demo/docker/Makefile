include $(shell make+)

MAKEPLUS_PATH := $(PWD)/bin:$(MAKEPLUS_PATH)

DOCKER_APP := simple-http-server

${+require-command(docker)}

start: ${+!bin/docker-running(%DOCKER_APP)!} \
	${+docker-built(%DOCKER_APP)|build}
	docker run --rm -tdp 8000:80 $<

stop: ${+docker-running(%DOCKER_APP)!}
	@echo docker stop $<

9a0c09538c8b::

build:
	docker build \
	    --tag $(DOCKER_APP) \
	    .
