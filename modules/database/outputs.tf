output "mssql_server_id" {
  description = "The ID of the MSSQL server"
  value       = azurerm_mssql_server.mssql_server.id
}

output "mssql_server_fqdn" {
  description = "The FQDN of the MSSQL server"
  value       = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}

output "mssql_database_ids" {
  description = "IDs of created databases"
  value       = { for k, v in azurerm_mssql_database.mssql_database : k => v.id }
}

output "firewall_rule_ids" {
  description = "IDs of firewall rules"
  value       = { for k, v in azurerm_mssql_firewall_rule.mssql_firewall_rule : k => v.id }
}
