# UAT Storage
variable "resource_group_name" { type = string }
variable "storage_account_name" { type = string }
variable "account_tier" { type = string }
variable "account_replication_type" { type = string }
variable "https_traffic_only_enabled" { type = bool }
variable "containers" { type = any }
variable "file_shares" { type = any }
variable "tags" { type = map(string) }
