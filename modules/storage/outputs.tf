output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the storage account"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "container_ids" {
  description = "IDs of created containers"
  value       = { for k, v in azurerm_storage_container.containers : k => v.id }
}

output "file_share_ids" {
  description = "IDs of created file shares"
  value       = { for k, v in azurerm_storage_share.shares : k => v.id }
}
