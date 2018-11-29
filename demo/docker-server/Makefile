include $(shell make+)

MAKEPLUS_PATH := $(PWD)
DOCKER_APP := simple-http-server
PORT ?= 8000

start: ${+!docker-running(%DOCKER_APP)!} \
	${+docker-built(%DOCKER_APP)|build}
	docker run --rm -tdp $(PORT):$(PORT) ${DOCKER_APP}

stop: ${+docker-running(%DOCKER_APP)!}
	docker stop $<

contact-server := curl -s localhost:$(PORT) &>/dev/null
test: $(+contact-server?pass|fail)

clean:
	docker rmi $(DOCKER_APP)

build:
	docker build --tag $(DOCKER_APP) .

pass fail: ; @echo $@ | tr a-z A-Z

${+require-command(docker)}
