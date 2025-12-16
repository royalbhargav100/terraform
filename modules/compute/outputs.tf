output "vm_ids" {
  description = "IDs of created virtual machines"
  value       = { for k, v in azurerm_linux_virtual_machine.vm : k => v.id }
}

output "vm_private_ips" {
  description = "Private IP addresses of created virtual machines"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "nic_ids" {
  description = "IDs of network interfaces"
  value       = { for k, v in azurerm_network_interface.nic : k => v.id }
}
