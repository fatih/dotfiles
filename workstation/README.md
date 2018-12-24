# Workstation build

1. Build image

```
$ packer build image.json
```

2. Create workstation

```
$ export DIGITALOCEAN_TOKEN="Put Your Token Here" 
$ terraform plan
$ terraform apply
```
