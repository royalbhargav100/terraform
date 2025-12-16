# UAT Networking
variable "resource_group_name" { type = string }
variable "vnet_name" { type = string }
variable "address_space" { type = list(string) }
variable "subnets" { type = any }
variable "network_security_groups" { type = any }
variable "tags" { type = map(string) }
