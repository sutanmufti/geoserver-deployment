output "ip_address" {
  value       = linode_instance.web.ip_address
  description = "The Public IP Address of the Linode instance"
}

output "id" {
  value = linode_instance.web.id
}