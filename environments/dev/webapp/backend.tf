terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "stgterraformbackend"
    container_name       = "tfstate"
    key                  = "dev/webapp/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
