#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

apt-get install -qq -y \
  build-essential \
  docker.io \
  git \
  jq \
  mosh \
  curl \
  unzip \
  openssh-server

echo "Creating directories"

mkdir -p /mnt/code /mnt/secrets

echo "Installing 1password"
curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/v0.5.5/op_linux_amd64_v0.5.5.zip && unzip 1password.zip op -d /usr/local/bin && rm 1password.zip

echo "=> Setting up dev service"
cat > dockerdev.service <<EOF
[Unit]
Description=dockerdev
Requires=docker.service
After=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill dev
ExecStartPre=-/usr/bin/docker rm dev
ExecStartPre=/usr/bin/docker pull fatih/dev
ExecStart=/usr/bin/docker run -h dev --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /mnt/code:/root/code -v /mnt/secrets:/root/secrets -v  --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev fatih/dev

[Install]
WantedBy=multi-user.target
EOF

sudo mv dockerdev.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable dockerdev
sudo systemctl start dockerdev

echo "Done!"
