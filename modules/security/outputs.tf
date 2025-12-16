output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.key_vault.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "secret_ids" {
  description = "IDs of created secrets"
  value       = { for k, v in azurerm_key_vault_secret.secrets : k => v.id }
  sensitive   = true
}
