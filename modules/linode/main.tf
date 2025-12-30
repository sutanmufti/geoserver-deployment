terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "3.7.0"
    }
  }
}

provider "linode" {}

resource "linode_instance" "web" {
  label           = var.label
  image           = "linode/ubuntu24.04"
  region          = var.region
  type            = var.type
  authorized_keys = var.ssh_key

  tags       = []
  swap_size  = 256
}
