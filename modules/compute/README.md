# Compute Module

This module creates Azure Virtual Machines with network interfaces.

## Usage

```hcl
module "compute" {
  source = "../../modules/compute"

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  admin_username      = "azureuser"

  virtual_machines = {
    vm1 = {
      name            = "my-vm-1"
      vm_size         = "Standard_B2s"
      subnet_id       = module.networking.subnet_ids["subnet1"]
      ssh_key_path    = "~/.ssh/id_rsa.pub"
      image_publisher = "Canonical"
      image_offer     = "UbuntuServer"
      image_sku       = "18.04-LTS"
      image_version   = "Latest"
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
- `admin_username` - Administrator username for VMs
- `virtual_machines` - Map of virtual machines to create
- `tags` - Tags to apply to all resources

## Outputs

- `vm_ids` - IDs of created virtual machines
- `vm_private_ips` - Private IP addresses of created virtual machines
- `nic_ids` - IDs of network interfaces
