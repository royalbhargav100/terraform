# Networking Module

This module creates Azure Virtual Networks, Subnets, and Network Security Groups.

## Usage

```hcl
module "networking" {
  source = "../../modules/networking"

  vnet_name           = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  subnets = {
    subnet1 = {
      name             = "subnet-1"
      address_prefixes = ["10.0.1.0/24"]
    }
  }

  tags = {
    Environment = "Development"
  }
}
```

## Inputs

- `vnet_name` - Name of the virtual network
- `address_space` - Address space for the virtual network
- `location` - Azure region for resources
- `resource_group_name` - Name of the resource group
- `subnets` - Map of subnets to create
- `network_security_groups` - Map of network security groups to create
- `tags` - Tags to apply to all resources

## Outputs

- `vnet_id` - The ID of the virtual network
- `vnet_name` - The name of the virtual network
- `subnet_ids` - Map of subnet IDs
- `nsg_ids` - Map of network security group IDs
