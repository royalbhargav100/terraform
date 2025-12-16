module "security" {
  source = "../../../modules/security"

  key_vault_name      = var.key_vault_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name
  access_policies     = var.access_policies
  secrets             = var.secrets
  tags                = var.tags
}
