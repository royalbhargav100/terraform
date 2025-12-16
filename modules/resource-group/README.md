# Resource Group Module

This module creates an Azure Resource Group.

## Usage

```hcl
module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = "my-resource-group"
  location            = "East US"

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
```

## Inputs

- `resource_group_name` - Name of the resource group
- `location` - Azure region for resources
- `tags` - Tags to apply to all resources

## Outputs

- `id` - The ID of the created resource group
- `name` - The name of the created resource group
- `location` - The location of the created resource group
