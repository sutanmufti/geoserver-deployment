terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "3.7.0"
    }
  }
}

provider "linode" {}


resource "linode_firewall" "firewall" {


    label = "fw-entry"
    inbound {
        label    = "allow-http"
        action   = "ACCEPT"
        protocol = "TCP"
        ports    = "80"
        ipv4     = ["0.0.0.0/0"]
        ipv6     = ["::/0"]
    }

    inbound {
        label    = "allow-https"
        action   = "ACCEPT"
        protocol = "TCP"
        ports    = "443"
        ipv4     = ["0.0.0.0/0"]
        ipv6     = ["::/0"]
    }

    inbound {
        label    = "allow-ssh"
        action   = "ACCEPT"
        protocol = "TCP"
        ports    = "22"
        ipv4     = ["0.0.0.0/0"]
        ipv6     = ["::/0"]
    }

    inbound_policy = "DROP"

    outbound_policy = "ACCEPT"

    linodes = var.linodes
}