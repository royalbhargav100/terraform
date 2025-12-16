#!/bin/bash

# This script initializes the Terraform backend storage account and container
# It should be run once before running terraform init

set -e

# Variables
RESOURCE_GROUP="rg-terraform-backend"
STORAGE_ACCOUNT="stgterraformbackend"
CONTAINER_NAME="tfstate"
LOCATION="East US"

echo "Creating resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location "$LOCATION"

echo "Creating storage account: $STORAGE_ACCOUNT"
az storage account create --resource-group $RESOURCE_GROUP \
  --name $STORAGE_ACCOUNT \
  --sku Standard_LRS \
  --encryption-services blob

echo "Creating blob container: $CONTAINER_NAME"
az storage container create --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT

echo "Backend initialization complete!"
