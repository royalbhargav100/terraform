variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "mssql_server_name" {
  description = "Name of the MSSQL server"
  type        = string
}

variable "mssql_server_version" {
  description = "Version of the MSSQL server"
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "Administrator login for MSSQL server"
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator password for MSSQL server"
  type        = string
  sensitive   = true
}

variable "databases" {
  description = "Map of databases to create"
  type = map(object({
    name      = string
    collation = string
    sku_name  = string
  }))
  default = {}
}

variable "firewall_rules" {
  description = "Map of firewall rules to create"
  type = map(object({
    name              = string
    start_ip_address  = string
    end_ip_address    = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
