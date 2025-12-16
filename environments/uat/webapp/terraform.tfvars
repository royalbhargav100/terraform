resource_group_name            = "rg-uat-terraform"
app_service_plan_name          = "asp-uat"
app_service_name               = "app-uat"
app_service_plan_sku_tier      = "Standard"
app_service_plan_sku_size      = "S2"
app_settings                   = {}
tags = {
  Environment = "UAT"
  ManagedBy   = "Terraform"
}
