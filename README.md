# Terraform Infrastructure

A comprehensive, modular Terraform project for managing Azure infrastructure across multiple environments (Development, UAT, and Production).

## Features

- **Modular Design**: Reusable Terraform modules for common Azure resources
- **Environment Management**: Separate configurations for dev, uat, and prod
- **CI/CD Integration**: Azure DevOps pipeline templates for automated deployments
- **State Management**: Remote state storage with Azure Storage Account backend
- **Comprehensive Documentation**: Architecture, deployment, and runbook guides
- **Helper Scripts**: Bash scripts for common operations

## Quick Start

### 1. Clone Repository

```bash
git clone <repository-url>
cd terraform-infrastructure
```

### 2. Initialize Backend

```bash
cd scripts
bash init-backend.sh
```

### 3. Deploy Development Environment

```bash
cd ../environments/dev/resource-group
terraform init
terraform plan
terraform apply
```

## Project Structure

```
terraform-infrastructure/
├── .azure-pipelines/      # Azure DevOps pipeline configurations
├── modules/               # Reusable Terraform modules
│   ├── resource-group/   # Resource group module
│   ├── networking/       # Virtual networks, subnets, NSGs
│   ├── compute/          # Virtual machines
│   ├── webapp/           # App services
│   ├── database/         # SQL databases
│   ├── storage/          # Storage accounts
│   └── security/         # Key vaults
├── environments/          # Environment-specific configurations
│   ├── dev/             # Development environment
│   ├── uat/             # UAT environment
│   └── prod/            # Production environment
├── scripts/              # Helper scripts
├── docs/                 # Documentation
├── .gitignore           # Git ignore rules
├── .terraform-version   # Terraform version
└── README.md            # This file
```

## Modules

### resource-group
Creates and manages Azure Resource Groups.

### networking
Manages Virtual Networks, Subnets, and Network Security Groups.

### compute
Manages Virtual Machines and Network Interfaces.

### webapp
Manages App Service Plans and App Services.

### database
Manages SQL Servers and Databases with firewall rules.

### storage
Manages Storage Accounts, Blob Containers, and File Shares.

### security
Manages Key Vaults and access policies.

## Environments

### Development (dev)
- Minimal configuration for development and testing
- Smaller resource sizes for cost optimization
- Rapid deployment for experimentation

### UAT (uat)
- Medium-sized resources for testing
- Enhanced networking and security
- Closer to production configuration

### Production (prod)
- Premium resource configurations
- High availability and disaster recovery
- Comprehensive monitoring and security

## Configuration

Each environment component has:

- `main.tf`: Module instantiation
- `variables.tf`: Variable definitions
- `terraform.tfvars`: Environment-specific values
- `backend.tf`: Remote state configuration
- `data.tf`: Data sources and references

## Deployment

### Manual Deployment

```bash
cd environments/{environment}/{component}
terraform init
terraform plan
terraform apply
```

### Scripted Deployment

```bash
# Validate all configurations
scripts/validate-terraform.sh

# Plan all components in an environment
scripts/plan-all.sh {environment}

# Apply all components in an environment
scripts/apply-all.sh {environment}
```

### CI/CD Pipeline

```bash
# Validate on pull request
azure-pipelines-ci.yml

# Deploy on merge to main
azure-pipelines-cd.yml

# Manual destroy trigger
azure-pipelines-destroy.yml
```

## Backend Configuration

Remote state is stored in Azure Storage:

- **Storage Account**: stgterraformbackend
- **Resource Group**: rg-terraform-backend
- **Container**: tfstate
- **Keys**: `{environment}/{component}/terraform.tfstate`

## State Files

Each environment has separate state files:

```
tfstate/
├── dev/resource-group/terraform.tfstate
├── dev/networking/terraform.tfstate
├── uat/resource-group/terraform.tfstate
├── prod/resource-group/terraform.tfstate
└── ...
```

## Prerequisites

- Terraform >= 1.5
- Azure CLI
- Azure subscription
- Appropriate Azure permissions

## Documentation

- [Architecture](./docs/architecture.md): System design and structure
- [Deployment Guide](./docs/deployment-guide.md): Step-by-step deployment instructions
- [Runbook](./docs/runbook.md): Operational procedures and troubleshooting

## Best Practices

### Security
- Store secrets in Azure Key Vault
- Use managed identities where possible
- Enable encryption for all data

### Cost Management
- Use appropriate resource SKUs
- Implement auto-shutdown for non-prod resources
- Monitor and review costs regularly

### Operational Excellence
- Maintain detailed documentation
- Implement proper change management
- Regularly backup state files
- Audit all infrastructure changes

## Troubleshooting

### Common Issues

1. **Backend initialization fails**
   - Verify Azure authentication: `az login`
   - Check subscription: `az account show`
   - Verify resource group exists

2. **Module not found**
   - Ensure relative paths are correct
   - Run `terraform init` in component directory

3. **State lock errors**
   - Check for running operations
   - Use `terraform force-unlock` if necessary

## Contributing

1. Create a feature branch
2. Make changes to modules or environments
3. Run `terraform validate` and `terraform fmt`
4. Create a pull request
5. Await approval and merge

## Support

For issues, questions, or contributions, please:

1. Check the [Deployment Guide](./docs/deployment-guide.md)
2. Review the [Runbook](./docs/runbook.md)
3. Contact the infrastructure team

## License

[Your License Here]

## Authors

[Your Name/Team]
