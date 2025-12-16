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
  type = any
}

variable "firewall_rules" {
  type = any
}

variable "tags" {
  type = map(string)
}
