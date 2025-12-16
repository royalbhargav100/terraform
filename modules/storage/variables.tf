variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "https_traffic_only_enabled" {
  description = "Enable HTTPS traffic only"
  type        = bool
  default     = true
}

variable "containers" {
  description = "Map of containers to create"
  type = map(object({
    name        = string
    access_type = string
  }))
  default = {}
}

variable "file_shares" {
  description = "Map of file shares to create"
  type = map(object({
    name  = string
    quota = number
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
