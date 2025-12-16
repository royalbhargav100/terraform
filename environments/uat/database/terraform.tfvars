resource_group_name           = "rg-uat-terraform"
mssql_server_name             = "sqluat001"
administrator_login           = "sqladmin"
administrator_login_password  = "ChangeMe!@123"
databases                     = {}
firewall_rules                = {}
tags = {
  Environment = "UAT"
  ManagedBy   = "Terraform"
}
