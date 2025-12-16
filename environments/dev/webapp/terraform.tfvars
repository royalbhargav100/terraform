resource_group_name            = "rg-dev-terraform"
app_service_plan_name          = "asp-dev"
app_service_name               = "app-dev"
app_service_plan_sku_tier      = "Standard"
app_service_plan_sku_size      = "S1"
app_settings                   = {}
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
}
