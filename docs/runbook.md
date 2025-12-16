# Runbook

## Incident Response

### Resource Creation Failed

1. **Check Terraform Output**
   ```bash
   terraform refresh
   terraform plan
   ```

2. **Review Error Message**
   - Check resource naming conflicts
   - Verify quotas and limits
   - Confirm permissions

3. **Remediate**
   ```bash
   terraform destroy -target=resource_type.resource_name
   terraform apply
   ```

### State Corruption

1. **Backup Current State**
   ```bash
   cp terraform.tfstate terraform.tfstate.backup
   ```

2. **Pull Remote State**
   ```bash
   terraform state pull > remote.tfstate
   ```

3. **Compare and Validate**
   ```bash
   terraform plan -out=tfplan
   ```

4. **Restore if Needed**
   ```bash
   terraform state push terraform.tfstate.backup
   ```

## Maintenance Tasks

### Weekly

- Review Terraform state
- Check for drift: `terraform plan`
- Validate connectivity to all resources

### Monthly

- Update Terraform version
- Review and update modules
- Audit access and permissions
- Check cost trends

### Quarterly

- Security assessment
- Disaster recovery drill
- Documentation review
- Capacity planning

## Common Commands Reference

### Initialize

```bash
terraform init
terraform init -upgrade
```

### Planning and Applying

```bash
terraform plan
terraform plan -out=tfplan
terraform apply
terraform apply tfplan
terraform apply -destroy -auto-approve
```

### State Management

```bash
terraform state list
terraform state show resource_name
terraform state rm resource_name
terraform state mv old_name new_name
```

### Debugging

```bash
terraform validate
terraform fmt
terraform graph
terraform console
```

## Performance Optimization

### Parallel Operations

```bash
terraform apply -parallelism=10
```

### Caching

```bash
export TF_INPUT=false
terraform apply -auto-approve
```

## Backup and Recovery

### Daily Backup

```bash
#!/bin/bash
BACKUP_DIR="./backups"
mkdir -p $BACKUP_DIR

for env in dev uat prod; do
  for component in resource-group networking compute webapp database storage; do
    if [ -f "environments/$env/$component/terraform.tfstate" ]; then
      cp "environments/$env/$component/terraform.tfstate" \
         "$BACKUP_DIR/tfstate_${env}_${component}_$(date +%Y%m%d_%H%M%S)"
    fi
  done
done
```

### Recovery Process

1. **Stop All Operations**
   - Cancel running pipelines
   - Lock state for manual recovery

2. **Restore State**
   ```bash
   terraform state push backup_file.tfstate
   ```

3. **Validate**
   ```bash
   terraform plan
   terraform refresh
   ```

4. **Resume Operations**
   - Unlock state
   - Resume normal operations

## Escalation Path

1. **Level 1 - Terraform Issues**
   - Check configuration syntax
   - Review recent changes
   - Validate module versions

2. **Level 2 - Azure Platform Issues**
   - Check Azure service status
   - Review Azure Portal logs
   - Contact Azure support if needed

3. **Level 3 - Architecture Issues**
   - Review design documents
   - Assess infrastructure scaling
   - Plan upgrades/migrations

## Contact Information

- **On-Call**: [Team Contact Info]
- **Escalation**: [Manager Contact]
- **Azure Support**: [Support Portal]
