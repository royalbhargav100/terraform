data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "webapp" {
  source = "../../../modules/webapp"

  location                      = data.azurerm_resource_group.rg.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  app_service_plan_name         = var.app_service_plan_name
  app_service_name              = var.app_service_name
  app_service_plan_sku_tier     = var.app_service_plan_sku_tier
  app_service_plan_sku_size     = var.app_service_plan_sku_size
  app_settings                  = var.app_settings
  tags                          = var.tags
}
