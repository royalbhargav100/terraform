resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  https_traffic_only_enabled = var.https_traffic_only_enabled

  tags = var.tags
}

resource "azurerm_storage_container" "containers" {
  for_each = var.containers

  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = each.value.access_type

  depends_on = [azurerm_storage_account.storage_account]
}

resource "azurerm_storage_share" "shares" {
  for_each = var.file_shares

  name               = each.value.name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota              = each.value.quota

  depends_on = [azurerm_storage_account.storage_account]
}
