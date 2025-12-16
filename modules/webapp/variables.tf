variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_plan_kind" {
  description = "Kind of App Service Plan"
  type        = string
  default     = "Linux"
}

variable "app_service_plan_reserved" {
  description = "Is this App Service Plan reserved"
  type        = bool
  default     = true
}

variable "app_service_plan_sku_tier" {
  description = "SKU tier for App Service Plan"
  type        = string
  default     = "Standard"
}

variable "app_service_plan_sku_size" {
  description = "SKU size for App Service Plan"
  type        = string
  default     = "S1"
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "dotnet_framework_version" {
  description = ".NET Framework version"
  type        = string
  default     = "v4.0"
}

variable "app_settings" {
  description = "Application settings"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
