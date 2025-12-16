# Deployment Guide

## Prerequisites

- Azure subscription with Owner or Contributor role
- Terraform installed (v1.5 or higher)
- Azure CLI installed and authenticated
- Git for version control

## Environment Setup

### 1. Authenticate with Azure

```bash
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### 2. Initialize Backend Storage

Run the initialization script to create the backend storage:

```bash
cd scripts
bash init-backend.sh
```

This creates:
- Resource group: `rg-terraform-backend`
- Storage account: `stgterraformbackend`
- Blob container: `tfstate`

### 3. Configure Service Principal (Optional for CI/CD)

For Azure Pipelines, create a service principal:

```bash
az ad sp create-for-rbac --name "TerraformServicePrincipal" --role="Contributor"
```

## Deployment Process

### Development Environment

1. **Validate Configuration**
   ```bash
   cd environments/dev/resource-group
   terraform init
   terraform validate
   ```

2. **Plan Deployment**
   ```bash
   terraform plan -out=tfplan
   ```

3. **Review Plan**
   - Examine the planned changes
   - Verify resource names and configurations
   - Check for any unexpected modifications

4. **Apply Configuration**
   ```bash
   terraform apply tfplan
   ```

### UAT Environment

Follow the same process with:
```bash
cd environments/uat/resource-group
```

### Production Environment

For production, follow these additional steps:

1. **Code Review**: Ensure all changes are reviewed
2. **Approval Required**: Obtain approval before deployment
3. **Backup**: Verify current state backups exist
4. **Staged Rollout**: Consider phased resource deployment

## Component Deployment Order

Deploy components in this order to manage dependencies:

1. **Resource Group**
   ```bash
   cd environments/{ENV}/resource-group
   terraform apply
   ```

2. **Networking**
   ```bash
   cd environments/{ENV}/networking
   terraform apply
   ```

3. **Storage**
   ```bash
   cd environments/{ENV}/storage
   terraform apply
   ```

4. **Database**
   ```bash
   cd environments/{ENV}/database
   terraform apply
   ```

5. **Compute**
   ```bash
   cd environments/{ENV}/compute
   terraform apply
   ```

6. **Web App**
   ```bash
   cd environments/{ENV}/webapp
   terraform apply
   ```

## Variables Management

### Using terraform.tfvars

Each component has a `terraform.tfvars` file. To customize:

1. Create `terraform.tfvars.local` (not committed)
2. Override specific variables
3. Terraform loads `.local` files automatically

### Environment Variables

Set Azure-specific variables:

```bash
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
```

## State Management

### View State

```bash
terraform state list
terraform state show resource_name
```

### State Lock

Terraform automatically locks state during operations. To manually unlock:

```bash
terraform force-unlock LOCK_ID
```

### Remote State Pull

Pull current remote state locally:

```bash
terraform state pull > backup.tfstate
```

## Troubleshooting

### Common Issues

1. **Authentication Failures**
   ```bash
   az login
   az account show
   ```

2. **State Lock Issues**
   - Check Azure DevOps running pipelines
   - Use `terraform force-unlock` if necessary

3. **Module Not Found**
   - Verify relative paths in modules
   - Ensure `.terraform` directory is initialized

### Debug Mode

Enable debug logging:

```bash
export TF_LOG=DEBUG
terraform apply
```

## Rollback Procedure

### To Previous Version

1. **From Local State Backup**
   ```bash
   terraform state push backup.tfstate
   terraform apply -destroy -auto-approve
   ```

2. **Using Git History**
   ```bash
   git checkout previous_commit -- environments/
   terraform apply
   ```

## Monitoring and Validation

### Post-Deployment Validation

1. **Verify Resources in Azure Portal**
2. **Check Network Connectivity**
3. **Test Application Functionality**
4. **Review Logs and Metrics**

### Health Checks

```bash
# List all resources
az resource list --resource-group rg-dev-terraform

# Check resource status
az vm get-instance-view --resource-group rg-dev-terraform --name vm-name
```

## Cost Optimization

1. Review resource sizing in `terraform.tfvars`
2. Consider using smaller SKUs for non-prod environments
3. Enable auto-shutdown for dev resources
4. Use Reserved Instances for prod workloads

## Security Best Practices

1. **Protect State Files**
   - Use encrypted storage backend
   - Restrict access to service principal
   - Audit state file access

2. **Secrets Management**
   - Use Key Vault for sensitive data
   - Never commit secrets to git
   - Rotate credentials regularly

3. **RBAC Configuration**
   - Use principle of least privilege
   - Implement segregation of duties
   - Regularly audit permissions
