resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.mssql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.mssql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  tags = var.tags
}

resource "azurerm_mssql_database" "mssql_database" {
  for_each = var.databases

  name      = each.value.name
  server_id = azurerm_mssql_server.mssql_server.id
  collation = each.value.collation
  sku_name  = each.value.sku_name

  tags = var.tags

  depends_on = [azurerm_mssql_server.mssql_server]
}

resource "azurerm_mssql_firewall_rule" "mssql_firewall_rule" {
  for_each = var.firewall_rules

  name             = each.value.name
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
