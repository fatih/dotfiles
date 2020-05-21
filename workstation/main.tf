terraform {
  required_version = ">= 0.12.0"
}
provider "digitalocean" {}

variable "region" {
  default = "nyc1"
}

resource "digitalocean_droplet" "dev" {
  name               = "dev"
  image              = "ubuntu-20-04-x64"
  size               = "s-2vcpu-4gb"
  region             = var.region
  backups            = true
  ipv6               = true
  ssh_keys           = ["93:3d:80:9e:52:6b:88:46:e2:2a:27:e7:c2:c6:df:b4"]                        # doctl compute ssh-key list

  provisioner "file" {
    source      = "../bootstrap.sh"
    destination = "/tmp/bootstrap.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_ed25519")
      timeout     = "2m"
      host = digitalocean_droplet.dev.ipv4_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh initialize",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_ed25519")
      timeout     = "2m"
      host = digitalocean_droplet.dev.ipv4_address
    }
  }
}

resource "digitalocean_firewall" "dev" {
  name = "dev"

  droplet_ids = [digitalocean_droplet.dev.id]

  inbound_rule {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
	}

  inbound_rule {
      protocol         = "udp"
      port_range       = "60000-60010"
      source_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}
}

output "public_ip" {
  value = digitalocean_droplet.dev.ipv4_address
}
