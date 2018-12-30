all: build

build:
	docker build --build-arg DOCKER_GROUP_ID=$(shell getent group docker 2>/dev/null | cut -d: -f3) -t fatih:dev .

run: kill
	docker run -it -h dev -d --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /home/fatih/code:/home/fatih/code -v /home/fatih/.ssh:/home/fatih/.ssh -v /home/fatih/.zsh_private:/home/fatih/.zsh_private -v /home/fatih/.zsh_history:/home/fatih/.zsh_history --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev fatih:dev 

ssh:
	mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/github_rsa -p 3222" fatih@localhost -- tmux new-session -AD -s main

kill:
	docker kill dev | true


.PHONY: all build run kill
