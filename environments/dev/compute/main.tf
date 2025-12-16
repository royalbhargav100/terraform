data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "compute" {
  source = "../../../modules/compute"

  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  admin_username      = var.admin_username
  virtual_machines    = var.virtual_machines
  tags                = var.tags
}
