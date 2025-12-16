resource_group_name          = "rg-dev-terraform"
storage_account_name         = "stgdev001"
account_tier                 = "Standard"
account_replication_type     = "LRS"
https_traffic_only_enabled   = true
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
  ManagedBy   = "Terraform"
}
