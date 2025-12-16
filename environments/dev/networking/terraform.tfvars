resource_group_name = "rg-dev-terraform"

vnet_name     = "vnet-dev"
address_space = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    name             = "subnet-dev-1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "subnet-dev-2"
    address_prefixes = ["10.0.2.0/24"]
  }
}

network_security_groups = {
  nsg1 = {
    name = "nsg-dev-1"
    rules = [
      {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
}
