output "id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.rg.id
}

output "name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "The location of the created resource group"
  value       = azurerm_resource_group.rg.location
}
