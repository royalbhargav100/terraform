data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "database" {
  source = "../../../modules/database"

  location                     = data.azurerm_resource_group.rg.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  mssql_server_name            = var.mssql_server_name
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  databases                    = var.databases
  firewall_rules               = var.firewall_rules
  tags                         = var.tags
}
