
terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "3.7.0"
    }
  }
}

# create a ~/.config/linode first. The token should be put there
provider "linode" {}

# register re-usable SSH key
resource "linode_sshkey" "my_ssh_key" {
  label   = "my_ssh_key"
  ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}

# puts the VM in a firewall. Allow HTTP, HTTPS, and SSH
module "fw" {
  source = "./modules/firewall"

  linodes = [
    module.vm.id
  ]
}

module "vm" {
  source = "./modules/linode"
  label  = var.label
  ssh_key = [
    linode_sshkey.my_ssh_key.ssh_key
  ]
}




resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.ini"

  # https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings
  # EOT supports multiline string
  content = <<-EOT
        [vm]
        ${module.vm.ip_address} ansible_user=root
    EOT
}
