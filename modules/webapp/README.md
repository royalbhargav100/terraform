# Web App Module

This module creates Azure App Service Plans and App Services.

## Usage

```hcl
module "webapp" {
  source = "../../modules/webapp"

  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg.name
  app_service_plan_name         = "my-app-service-plan"
  app_service_name              = "my-web-app"
  app_service_plan_sku_tier     = "Standard"
  app_service_plan_sku_size     = "S1"

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  tags = {
    Environment = "Development"
  }
}
```

## Inputs

- `location` - Azure region for resources
- `resource_group_name` - Name of the resource group
- `app_service_plan_name` - Name of the App Service Plan
- `app_service_plan_kind` - Kind of App Service Plan
- `app_service_plan_reserved` - Is this App Service Plan reserved
- `app_service_plan_sku_tier` - SKU tier for App Service Plan
- `app_service_plan_sku_size` - SKU size for App Service Plan
- `app_service_name` - Name of the App Service
- `dotnet_framework_version` - .NET Framework version
- `app_settings` - Application settings
- `tags` - Tags to apply to all resources

## Outputs

- `app_service_plan_id` - The ID of the App Service Plan
- `app_service_id` - The ID of the App Service
- `app_service_default_hostname` - The default hostname of the App Service
- `app_service_outbound_ip_addresses` - Outbound IP addresses of the App Service
