resource_group_name = "rg-dev-terraform"
key_vault_name      = "kv-dev-secrets"
tenant_id           = ""  # Replace with your Azure Tenant ID
sku_name            = "standard"

# Development access policies - minimal for dev environment
access_policies = {}

# Development secrets - empty by default, add as needed
secrets = {}

tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Module      = "Security"
  CreatedAt   = "2025-12-16"
}
