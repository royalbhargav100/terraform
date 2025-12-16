resource_group_name          = "rg-uat-terraform"
storage_account_name         = "stguat001"
account_tier                 = "Standard"
account_replication_type     = "GRS"
https_traffic_only_enabled   = true
containers                   = {}
file_shares                  = {}
tags = {
  Environment = "UAT"
  ManagedBy   = "Terraform"
}
