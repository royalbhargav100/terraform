resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.app_service_plan_kind
  reserved            = var.app_service_plan_reserved

  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }

  tags = var.tags
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = var.dotnet_framework_version
    scm_type                 = "LocalGit"
  }

  app_settings = var.app_settings

  tags = var.tags

  depends_on = [azurerm_app_service_plan.app_service_plan]
}
