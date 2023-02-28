SHELL := /bin/bash

image_name=env_container

.PHONY: build
build: build-alpine

.PHONY: run
run:
	docker run -it -v ${PWD}/config:/root/config:rw ${image_name} /bin/bash

.PHONY: build-alpine
build-alpine:
	docker build --file ./envs/Dockerfile-alpine -t ${image_name} .

.PHONY: build-archlinux
build-archlinux:
	docker build --file ./envs/Dockerfile-archlinux -t ${image_name} .

.PHONY: build-ubuntu-22.04
build-ubuntu-22.04:
	docker build --file ./envs/Dockerfile-ubuntu_22.04 -t ${image_name} .
