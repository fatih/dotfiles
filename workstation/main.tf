variable "region" {
  description = "Digital Ocean Frankfurt Data Center 1"
  default     = "fra1"
}

variable "image" {
  description = "Fatih's Dev Image"
  default     = "41753048"
}

provider "digitalocean" {}

resource "digitalocean_droplet" "dev" {
  ssh_keys           = [23737229]      # Key example
  image              = "${var.image}"
  region             = "${var.region}"
  size               = "s-4vcpu-8gb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "dev"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      private_key = "${file("~/.ssh/ipad_rsa")}"
      user        = "root"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "dev" {
  name = "dev"

  droplet_ids = ["${digitalocean_droplet.dev.id}"]

  inbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "udp"
      port_range       = "60000-60100"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

output "public_ip" {
  value = "${digitalocean_droplet.dev.ipv4_address}"
}
