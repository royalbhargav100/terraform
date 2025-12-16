resource_group_name = "rg-prod-terraform"
key_vault_name      = "kv-prod-secrets"
tenant_id           = ""  # Replace with your Azure Tenant ID
sku_name            = "premium"  # Premium for production

# Production access policies - strict and controlled
access_policies = {}

# Production secrets - add production credentials
secrets = {}

tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
  Module      = "Security"
  Compliance  = "Required"
  CreatedAt   = "2025-12-16"
}
