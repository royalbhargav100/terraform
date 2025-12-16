variable "resource_group_name" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "app_service_plan_sku_tier" {
  type = string
}

variable "app_service_plan_sku_size" {
  type = string
}

variable "app_settings" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}
