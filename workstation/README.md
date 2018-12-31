# Workstation build

This terraform setup creates a workstation on DigitalOcean with my personal
setup and ready to use mosh setup.

## Install


1. Create workstation droplet

```
$ export DIGITALOCEAN_TOKEN="Put Your Token Here" 
$ terraform plan
$ terraform apply -auto-approve
```
2. Pull secrets

This downloads my secrets from 1password and puts them into the /mnt/secrets folder

```
$ ssh -i ~/.ssh/id_rsa root@157.230.21.84
$ cd /mnt/secrets
$ ./pull-secrets.sh
```

3. SSH via mosh:

```
$ mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/github_rsa -p 3222" root@<DROPLET_IP> -- tmux new-session -AD -s main
```

## Todo

* Encrypt /mnt/secrets
* Resync back some dynamic files (such as `.zsh_history`) back to 1password occasionally
