data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "storage" {
  source = "../../../modules/storage"

  location                     = data.azurerm_resource_group.rg.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  storage_account_name         = var.storage_account_name
  account_tier                 = var.account_tier
  account_replication_type     = var.account_replication_type
  https_traffic_only_enabled   = var.https_traffic_only_enabled
  containers                   = var.containers
  file_shares                  = var.file_shares
  tags                         = var.tags
}
