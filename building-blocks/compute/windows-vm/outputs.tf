# terraform output prints these after apply. Password is never an output.

output "id" {
  description = "Virtual machine ID."
  value       = azurerm_windows_virtual_machine.this.id
}

output "name" {
  description = "Virtual machine name (WCC compute pattern)."
  value       = azurerm_windows_virtual_machine.this.name
}

output "resource_group_name" {
  description = "Resource group that holds the VM."
  value       = azurerm_windows_virtual_machine.this.resource_group_name
}

output "private_ip_address" {
  description = "Private IP on the NIC. There is no public IP."
  value       = azurerm_network_interface.this.private_ip_address
}

output "network_interface_id" {
  description = "NIC ID."
  value       = azurerm_network_interface.this.id
}

output "network_security_group_id" {
  description = "NSG ID attached to the NIC."
  value       = azurerm_network_security_group.this.id
}

output "principal_id" {
  description = "System assigned identity, for role assignments."
  value       = azurerm_windows_virtual_machine.this.identity[0].principal_id
}