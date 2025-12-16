resource_group_name = "rg-uat-terraform"
vnet_name     = "vnet-uat"
address_space = ["10.1.0.0/16"]
subnets       = {}
network_security_groups = {}
tags = {
  Environment = "UAT"
  ManagedBy   = "Terraform"
}
