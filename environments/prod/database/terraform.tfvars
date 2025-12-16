resource_group_name           = "rg-prod-terraform"
mssql_server_name             = "sqlprod001"
administrator_login           = "sqladmin"
administrator_login_password  = "ChangeMe!@123"
databases                     = {}
firewall_rules                = {}
tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
}
