#!/bin/bash

set -eu

echo "Authenticating with 1Password"
export OP_SESSION_my=$(op signin https://my.1password.com ftharsln@gmail.com --output=raw)

echo "Pulling secrets"
# private keys
op get document 'github_rsa' > github_rsa
op get document 'zsh_private' > zsh_private
op get document 'zsh_history' > zsh_history

ln -s /mnt/secrets/github_rsa ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa
ln -s /mnt/secrets/zsh_private ~/.zsh_private
ln -s /mnt/secrets/zsh_history ~/.zsh_history

echo "Done!"
