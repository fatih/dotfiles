variable "region" {
  description = "Digital Ocean Frankfurt Data Center 1"
  default     = "fra1"
}

variable "image" {
  description = "Fatih's Dev Image"
  default     = "41745985"
}

provider "digitalocean" {}

resource "digitalocean_droplet" "workstation" {
  ssh_keys           = [23737229]      # Key example
  image              = "${var.image}"
  region             = "${var.region}"
  size               = "s-4vcpu-8gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "workstation"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/ipad_rsa")}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

output "public_ip" {
  value = "${digitalocean_droplet.workstation.ipv4_address}"
}
