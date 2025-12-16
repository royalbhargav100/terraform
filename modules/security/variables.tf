variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "sku_name" {
  description = "SKU of the Key Vault"
  type        = string
  default     = "standard"
}

variable "access_policies" {
  description = "Map of access policies"
  type = map(object({
    object_id           = string
    key_permissions     = list(string)
    secret_permissions  = list(string)
  }))
  default = {}
}

variable "secrets" {
  description = "Map of secrets to create"
  type = map(object({
    name           = string
    value          = string
    content_type   = string
  }))
  sensitive = true
  default   = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
