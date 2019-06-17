GITCOMMIT := $(shell git rev-parse --short=7 HEAD 2>/dev/null)
NAME=dev

all: build

build:
	@echo "==> Building fatih/${NAME}:$(GITCOMMIT)"
	docker build -t fatih/${NAME}:${GITCOMMIT} .
	docker tag fatih/${NAME}:$(GITCOMMIT) fatih/${NAME}:latest

push:
	@echo "==> Publishing fatih/${NAME}:$(GITCOMMIT)"
	@docker tag fatih/${NAME}:$(GITCOMMIT) fatih/${NAME}:latest
	@docker push fatih/${NAME}:$(GITCOMMIT)
	@docker push fatih/${NAME}:latest
	@echo "==> Your image is now available at fatih/${NAME}:$(GITCOMMIT)"


run: kill
	docker run -d -h dev --net=host --rm -e TZ=Europe/Istanbul -v /var/run/docker.sock:/var/run/docker.sock  -v /mnt/code:/root/code -v /mnt/secrets:/root/secrets --privileged --name dev fatih/dev:50a9c22

ssh:
	mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i /root/.ssh/github_rsa -p 3222" root@localhost -- tmux new-session -AD -s main

kill:
	docker kill dev | true


.PHONY: all build run kill
