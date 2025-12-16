terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "stgterraformbackend"
    container_name       = "tfstate"
    key                  = "dev/compute/terraform.tfstate"
  }
}
