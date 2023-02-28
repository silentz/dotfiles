SHELL := /bin/bash
.PHONY: build run

image_name=test

build:
	docker build . -t ${image_name}

run:
	docker run -it -v ${PWD}/config:/root/config:rw ${image_name} /bin/sh
