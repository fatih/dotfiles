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

2. SSH via mosh:

```
mosh --no-init --ssh="ssh -i /Users/fatih/.ssh/github_rsa" fatih@<DROPLET_ID> -- tmux new-session -A -s main
```
