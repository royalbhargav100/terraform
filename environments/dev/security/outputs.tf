output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = module.security.key_vault_id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = module.security.key_vault_uri
}

output "secret_ids" {
  description = "IDs of created secrets"
  value       = module.security.secret_ids
  sensitive   = true
}
