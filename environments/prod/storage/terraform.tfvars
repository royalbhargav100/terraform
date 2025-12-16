resource_group_name          = "rg-prod-terraform"
storage_account_name         = "stgprod001"
account_tier                 = "Standard"
account_replication_type     = "RAGRS"
https_traffic_only_enabled   = true
containers                   = {}
file_shares                  = {}
tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
}
