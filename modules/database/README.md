# Database Module

This module creates Azure SQL Server and Databases.

## Usage

```hcl
module "database" {
  source = "../../modules/database"

  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg.name
  mssql_server_name             = "my-sql-server"
  administrator_login           = "sqladmin"
  administrator_login_password  = random_password.sql_password.result

  databases = {
    db1 = {
      name      = "mydb"
      collation = "SQL_Latin1_General_CP1_CI_AS"
      sku_name  = "S0"
    }
  }

  firewall_rules = {
    rule1 = {
      name              = "AllowAzure"
      start_ip_address  = "0.0.0.0"
      end_ip_address    = "0.0.0.0"
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Inputs

- `location` - Azure region for resources
- `resource_group_name` - Name of the resource group
- `mssql_server_name` - Name of the MSSQL server
- `mssql_server_version` - Version of the MSSQL server
- `administrator_login` - Administrator login for MSSQL server
- `administrator_login_password` - Administrator password for MSSQL server
- `databases` - Map of databases to create
- `firewall_rules` - Map of firewall rules to create
- `tags` - Tags to apply to all resources

## Outputs

- `mssql_server_id` - The ID of the MSSQL server
- `mssql_server_fqdn` - The FQDN of the MSSQL server
- `mssql_database_ids` - IDs of created databases
- `firewall_rule_ids` - IDs of firewall rules
