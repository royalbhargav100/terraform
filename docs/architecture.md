# Terraform Infrastructure Architecture

## Overview

This Terraform infrastructure project provides a modular, environment-based approach to managing Azure resources across multiple environments (Dev, UAT, Prod).

## Architecture Components

### Modules

The `modules/` directory contains reusable Terraform modules:

- **resource-group**: Creates and manages Azure Resource Groups
- **networking**: Manages Virtual Networks, Subnets, and Network Security Groups
- **compute**: Manages Virtual Machines and Network Interfaces
- **webapp**: Manages App Service Plans and App Services
- **database**: Manages SQL Servers and Databases
- **storage**: Manages Storage Accounts, Containers, and File Shares
- **security**: Manages Key Vaults and access policies

### Environments

The `environments/` directory contains environment-specific configurations:

- **dev**: Development environment configurations
- **uat**: User Acceptance Testing environment configurations
- **prod**: Production environment configurations

Each environment has subdirectories for each infrastructure component.

## Directory Structure

```
terraform-infrastructure/
├── modules/                    # Reusable modules
├── environments/               # Environment-specific configurations
│   ├── dev/                   # Development environment
│   ├── uat/                   # UAT environment
│   └── prod/                  # Production environment
├── .azure-pipelines/          # Azure DevOps pipeline configurations
├── scripts/                   # Helper scripts
├── docs/                      # Documentation
└── .gitignore                 # Git ignore rules
```

## Backend Configuration

All environments use Azure Storage Account as the Terraform backend:

- **Storage Account**: `stgterraformbackend`
- **Resource Group**: `rg-terraform-backend`
- **Container**: `tfstate`

Each environment has its own state file:
- `dev/**/terraform.tfstate`
- `uat/**/terraform.tfstate`
- `prod/**/terraform.tfstate`

## Deployment Strategy

1. **Plan**: Generate execution plan for infrastructure changes
2. **Review**: Review proposed changes in Azure DevOps
3. **Apply**: Apply approved changes to target environment
4. **Destroy**: Tear down infrastructure (manual trigger)

## Naming Conventions

- Resource groups: `rg-{environment}-{purpose}`
- Virtual networks: `vnet-{environment}`
- Storage accounts: `stg{environment}{number}`
- SQL servers: `sql{environment}{number}`
- App services: `app-{environment}`

## Tagging Strategy

All resources are tagged with:

- **Environment**: dev, uat, or prod
- **ManagedBy**: Terraform
- **CreatedAt**: Date of creation (when applicable)

## Prerequisites

- Azure subscription with appropriate permissions
- Terraform >= 1.5
- Azure CLI configured
- Service Principal or Azure CLI authentication

## Quick Start

### 1. Initialize Backend

```bash
cd scripts
bash init-backend.sh
```

### 2. Validate Configuration

```bash
cd scripts
bash validate-terraform.sh
```

### 3. Plan Deployment

```bash
cd scripts
bash plan-all.sh dev
```

### 4. Apply Configuration

```bash
cd scripts
bash apply-all.sh dev
```

## CI/CD Integration

Three Azure Pipeline definitions are provided:

- **azure-pipelines-ci.yml**: Validates configuration on PR
- **azure-pipelines-cd.yml**: Deploys on merge to main
- **azure-pipelines-destroy.yml**: Manual destroy trigger
