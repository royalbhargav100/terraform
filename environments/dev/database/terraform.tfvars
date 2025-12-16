resource_group_name           = "rg-dev-terraform"
mssql_server_name             = "sqldev001"
administrator_login           = "sqladmin"
administrator_login_password  = "ChangeMe!@123"
databases = {
  devdb = {
    name      = "devdb"
    collation = "SQL_Latin1_General_CP1_CI_AS"
    sku_name  = "S0"
  }
}
firewall_rules = {
  azure_services = {
    name              = "AllowAzureServices"
    start_ip_address  = "0.0.0.0"
    end_ip_address    = "0.0.0.0"
  }
}
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
}
