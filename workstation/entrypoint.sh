#!/bin/sh

set -e

echo "Checking for secrets volume..."
if [ ! -d /mnt/secrets ]; then
    echo "/mnt/secrets is not attached!"
    exit 1
fi

ln -s /mnt/secrets/github_rsa ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa
ln -s /mnt/secrets/zsh_private ~/.zsh_private
ln -s /mnt/secrets/zsh_history ~/.zsh_history

/usr/sbin/sshd -D
