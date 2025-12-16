resource_group_name = "rg-uat-terraform"
key_vault_name      = "kv-uat-secrets"
tenant_id           = ""  # Replace with your Azure Tenant ID
sku_name            = "standard"

# UAT access policies - enhanced for testing
access_policies = {}

# UAT secrets - add as needed for testing
secrets = {}

tags = {
  Environment = "UAT"
  ManagedBy   = "Terraform"
  Module      = "Security"
  CreatedAt   = "2025-12-16"
}
