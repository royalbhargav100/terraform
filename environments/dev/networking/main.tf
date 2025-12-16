data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "networking" {
  source = "../../../modules/networking"

  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnets             = var.subnets
  network_security_groups = var.network_security_groups
  tags                = var.tags
}
