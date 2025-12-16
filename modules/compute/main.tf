resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.virtual_machines

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = each.value.vm_size

  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(each.value.ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  tags = var.tags

  depends_on = [azurerm_network_interface.nic]
}

resource "azurerm_network_interface" "nic" {
  for_each = var.virtual_machines

  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "testConfiguration"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}
