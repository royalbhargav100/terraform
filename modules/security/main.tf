resource "azurerm_key_vault" "key_vault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                  = var.tenant_id
  sku_name                   = var.sku_name

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "access_policies" {
  for_each = var.access_policies

  key_vault_id       = azurerm_key_vault.key_vault.id
  tenant_id          = var.tenant_id
  object_id          = each.value.object_id

  key_permissions    = each.value.key_permissions
  secret_permissions = each.value.secret_permissions

  depends_on = [azurerm_key_vault.key_vault]
}

resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.secrets

  name            = each.value.name
  value           = each.value.value
  key_vault_id    = azurerm_key_vault.key_vault.id
  content_type    = each.value.content_type

  depends_on = [azurerm_key_vault.key_vault]
}
