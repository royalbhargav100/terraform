resource_group_name            = "rg-prod-terraform"
app_service_plan_name          = "asp-prod"
app_service_name               = "app-prod"
app_service_plan_sku_tier      = "Premium"
app_service_plan_sku_size      = "P1V2"
app_settings                   = {}
tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
}
