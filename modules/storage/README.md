# Storage Module

This module creates Azure Storage Accounts with containers and file shares.

## Usage

```hcl
module "storage" {
  source = "../../modules/storage"

  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  storage_account_name      = "mystorageaccount"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  https_traffic_only_enabled = true

  containers = {
    data = {
      name        = "data"
      access_type = "private"
    }
  }

  file_shares = {
    share1 = {
      name  = "fileshare"
      quota = 100
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
- `storage_account_name` - Name of the storage account
- `account_tier` - Storage account tier
- `account_replication_type` - Storage account replication type
- `https_traffic_only_enabled` - Enable HTTPS traffic only
- `containers` - Map of containers to create
- `file_shares` - Map of file shares to create
- `tags` - Tags to apply to all resources

## Outputs

- `storage_account_id` - The ID of the storage account
- `storage_account_name` - The name of the storage account
- `storage_account_primary_blob_endpoint` - The primary blob endpoint of the storage account
- `container_ids` - IDs of created containers
- `file_share_ids` - IDs of created file shares
