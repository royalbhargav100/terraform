# UAT Compute
variable "resource_group_name" { type = string }
variable "admin_username" { type = string }
variable "virtual_machines" { type = any }
variable "tags" { type = map(string) }
