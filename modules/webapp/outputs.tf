output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_app_service_plan.app_service_plan.id
}

output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_app_service.app_service.id
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service"
  value       = azurerm_app_service.app_service.default_site_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP addresses of the App Service"
  value       = azurerm_app_service.app_service.outbound_ip_addresses
}
