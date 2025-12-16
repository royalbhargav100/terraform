# Security Module

This module creates Azure Key Vault with access policies and secrets.

## Usage

```hcl
module "security" {
  source = "../../modules/security"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  key_vault_name      = "my-key-vault"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policies = {
    policy1 = {
      object_id          = data.azurerm_client_config.current.object_id
      key_permissions    = ["Get", "List", "Create"]
      secret_permissions = ["Get", "List", "Set"]
    }
  }

  secrets = {
    secret1 = {
      name         = "my-secret"
      value        = "secret-value"
      content_type = "text/plain"
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Inputs

- `location` - Azure region for resources
- `resource_group_name` - Name of the resource group
- `key_vault_name` - Name of the Key Vault
- `tenant_id` - Azure Tenant ID
- `sku_name` - SKU of the Key Vault
- `access_policies` - Map of access policies
- `secrets` - Map of secrets to create
- `tags` - Tags to apply to all resources

## Outputs

- `key_vault_id` - The ID of the Key Vault
- `key_vault_uri` - The URI of the Key Vault
- `secret_ids` - IDs of created secrets
