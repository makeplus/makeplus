include $(shell ../../bin/make+)

$(warning THIS CODE IS NOT QUITE WORKING YET)

MAKEPLUS_PATH := $(PWD)/bin:$(MAKEPLUS_PATH)

DOCKER_APP := simple-http-server

${+require-command(docker)}

start: ${+!docker-running(%DOCKER_APP)!} \
	${+docker-built(%DOCKER_APP)|build}
	docker run --rm -tdp 8000:80 $<

stop: ${+docker-running(%DOCKER_APP)!}
	docker stop $<

build:
	docker build \
	    --tag $(DOCKER_APP) \
	    .
