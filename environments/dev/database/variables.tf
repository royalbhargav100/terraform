variable "resource_group_name" {
  type = string
}

variable "mssql_server_name" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type      = string
  sensitive = true
}

variable "databases" {
  type = map(object({
    name      = string
    collation = string
    sku_name  = string
  }))
}

variable "firewall_rules" {
  type = map(object({
    name              = string
    start_ip_address  = string
    end_ip_address    = string
  }))
}

variable "tags" {
  type = map(string)
}
