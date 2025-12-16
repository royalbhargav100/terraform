resource_group_name = "rg-prod-terraform"
vnet_name     = "vnet-prod"
address_space = ["10.2.0.0/16"]
subnets       = {}
network_security_groups = {}
tags = {
  Environment = "Production"
  ManagedBy   = "Terraform"
}
