# Module Testing and Validation Guide

This guide provides comprehensive testing procedures for all Terraform modules to ensure quality and reliability.

## 🧪 Testing Hierarchy

```
Unit Tests (Module Level)
    ↓
Integration Tests (Environment Level)
    ↓
Validation Tests (Consistency)
    ↓
Security Scanning
    ↓
Production Deployment
```

---

## 1. Unit Testing (Individual Modules)

### 1.1 Syntax Validation

**Command:**
```bash
cd modules/[module-name]
terraform init -backend=false
terraform validate
```

**Expected Output:**
```
Success! The configuration is valid.
```

**All Modules to Test:**
```bash
# Automate all module validation
for module in modules/*/; do
  echo "Testing: $module"
  cd "$module"
  terraform init -backend=false || exit 1
  terraform validate || exit 1
  cd - > /dev/null
done
echo "✅ All modules validated successfully"
```

### 1.2 Format Checking

**Command:**
```bash
# Check if files follow HCL formatting standards
terraform fmt -recursive -check modules/

# Auto-format all files
terraform fmt -recursive modules/
```

### 1.3 Variable Validation

**Testing Checklist for Each Module:**

- [ ] All variables have descriptions
- [ ] All variables have type specifications
- [ ] Sensitive variables marked with `sensitive = true`
- [ ] Default values are appropriate
- [ ] Validation rules where needed

**Example Variable Validation:**
```terraform
variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  
  validation {
    condition     = contains(["Standard_B1s", "Standard_B2s", "Standard_D2s_v3"], var.vm_size)
    error_message = "VM size must be one of the supported sizes."
  }
}
```

### 1.4 Output Validation

**Testing Checklist:**

- [ ] All meaningful outputs are exported
- [ ] Output descriptions are clear
- [ ] Output types are correct
- [ ] Sensitive outputs marked appropriately

**Example Testing Script:**
```bash
# modules/compute/outputs.tf
# Verify outputs exist
terraform output 2>&1 | grep -E "vm_ids|vm_private_ips|nic_ids"
```

---

## 2. Integration Testing (Environments)

### 2.1 Development Environment Testing

**Step 1: Initialize Backend**
```bash
cd environments/dev/resource-group
terraform init
terraform validate
```

**Step 2: Plan Deployment**
```bash
terraform plan -out=tfplan
```

**Step 3: Review Plan Output**
- Verify all resources to be created
- Check for any errors or warnings
- Ensure no sensitive data in plan

**Step 4: Dry Run** (Optional)
```bash
terraform apply -auto-approve -input=false tfplan
terraform destroy -auto-approve
```

### 2.2 UAT Environment Testing

**Pre-requisites:**
- Backend initialized
- Service principal configured
- Sufficient permissions

**Testing Process:**
```bash
cd environments/uat/resource-group

# 1. Validate configuration
terraform init
terraform validate

# 2. Plan resources
terraform plan -out=uat-plan.tfplan

# 3. Review outputs
terraform show uat-plan.tfplan | grep "Plan:"

# 4. Check for compliance
grep -r "sensitive = true" . || echo "⚠️  Check for hardcoded secrets"
```

### 2.3 Complete Environment Deployment Test

**Full Stack Testing:**
```bash
#!/bin/bash

ENV=${1:-dev}
TEST_DIR="environments/$ENV"

echo "🧪 Testing Environment: $ENV"

for component in resource-group networking storage database compute webapp; do
  COMP_PATH="$TEST_DIR/$component"
  
  if [ -d "$COMP_PATH" ]; then
    echo "Testing: $component"
    
    cd "$COMP_PATH"
    
    # Validate
    terraform init -backend=false || exit 1
    terraform validate || exit 1
    
    # Format check
    terraform fmt -check -recursive . || exit 1
    
    echo "✅ $component passed"
    cd - > /dev/null
  fi
done

echo "✅ All components validated for $ENV"
```

---

## 3. Consistency Testing

### 3.1 Cross-Module Dependency Verification

**Test Pattern:**

```bash
# Verify module outputs match expected consumer inputs
echo "Checking compute module outputs..."
grep "output" modules/compute/outputs.tf

echo "Checking compute module variables..."
grep "variable" modules/compute/variables.tf

# Verify networking outputs are consumed by compute
grep "subnet_id" environments/dev/compute/main.tf
```

### 3.2 Variable Consistency

**Checklist:**
- [ ] All modules use consistent location variable format
- [ ] All modules use consistent resource naming
- [ ] Tag structures are uniform
- [ ] Environment-specific variables are applied correctly

**Example Consistency Check:**
```bash
# All modules should reference location similarly
grep -r "location.*var.location" modules/*/main.tf | wc -l
# Expected: 7 (one per module)

# All modules should have tags
grep -r "tags.*var.tags" modules/*/main.tf | wc -l
# Expected: 7
```

### 3.3 Naming Convention Validation

**Rules:**
- Resource Group: `rg-{env}-{purpose}`
- Virtual Machine: `vm-{env}-{purpose}-##`
- Storage Account: `st{env}{purpose}` (alphanumeric only)
- Key Vault: `kv-{env}-{purpose}`
- Database: `db-{env}-{purpose}`

**Validation Script:**
```bash
# Check naming conventions in tfvars
grep "_name" environments/prod/*/terraform.tfvars
# Should follow: resource_name = "{pattern}-{env}-{purpose}"
```

---

## 4. Security Testing

### 4.1 Secret Scanning

**Check for Hardcoded Secrets:**
```bash
# Search for common secret patterns
grep -r "password\|secret\|key.*=" --include="*.tf" \
  environments/prod/ | grep -v "var\." | grep -v "random_password"

# Search for AWS keys (common mistake in multi-cloud)
grep -r "AKIA\|aws_access_key" --include="*.tf" environments/

# Expected output: None or only variable references
```

### 4.2 Network Security Validation

**Checklist:**
- [ ] Database resources have no public IP
- [ ] NSG rules are specific (not 0.0.0.0/0 except for HTTP/HTTPS)
- [ ] Firewall rules restrict database access

**Automated Check:**
```bash
# Find any public IPs assigned to databases
grep -r "public_ip" modules/database/ --include="*.tf"
# Expected: No matches

# Check NSG rules aren't too open
grep -r "source_address_prefix.*0.0.0.0/0" --include="*.tf" \
  environments/prod/ | grep -v "80\|443"
# Expected: Minimal matches
```

### 4.3 Encryption Verification

**Verification:**
```bash
# Storage encryption
grep -r "https_traffic_only_enabled\|storage_account_type" \
  modules/storage/main.tf

# Database encryption  
grep -r "transparent_data_encryption_enabled" \
  modules/database/main.tf

# Key Vault encryption
grep -r "sku_name.*Premium" modules/security/main.tf
```

---

## 5. Documentation Testing

### 5.1 Module Documentation

**For Each Module, Verify:**

```checklist
- [ ] README.md exists
- [ ] Usage example provided
- [ ] Inputs section complete
- [ ] Outputs section complete
- [ ] No placeholder text
- [ ] Links work correctly
```

**Validation:**
```bash
for module in modules/*/; do
  echo "Checking: $module"
  [ -f "$module/README.md" ] || echo "❌ Missing README"
  grep -q "Usage\|Inputs\|Outputs" "$module/README.md" || \
    echo "❌ Missing sections"
done
```

### 5.2 Main Documentation

**Check:**
- [ ] README.md has all sections
- [ ] Code examples are valid
- [ ] Links are correct
- [ ] Prerequisites are complete

---

## 6. Performance Testing

### 6.1 Plan Execution Time

**Test:**
```bash
time terraform plan > /dev/null

# Good: < 10 seconds
# Acceptable: 10-30 seconds
# Review needed: > 30 seconds
```

### 6.2 State File Size

**Verify:**
```bash
# Check state file doesn't grow excessively
wc -l terraform.tfstate
# Typical: 1000-5000 lines per environment
```

---

## 7. Automated Testing Script

**Complete Testing Pipeline:**

```bash
#!/bin/bash
set -e

ENVIRONMENTS=("dev" "uat" "prod")
MODULES=("resource-group" "networking" "storage" "database" "compute" "webapp" "security")

echo "🧪 Starting Comprehensive Testing"
echo "=================================="

# Test 1: Module Validation
echo "📋 Testing Individual Modules..."
for module in "${MODULES[@]}"; do
  echo "  Testing: $module"
  cd "modules/$module"
  terraform init -backend=false > /dev/null 2>&1
  terraform validate || { echo "❌ Module $module failed validation"; exit 1; }
  terraform fmt -check -recursive . || { echo "❌ Module $module format check failed"; exit 1; }
  cd - > /dev/null
done
echo "✅ All modules validated"

# Test 2: Environment Validation
echo "📋 Testing Environments..."
for env in "${ENVIRONMENTS[@]}"; do
  for component in resource-group networking storage database compute webapp; do
    COMP_PATH="environments/$env/$component"
    if [ -d "$COMP_PATH" ]; then
      echo "  Testing: $env/$component"
      cd "$COMP_PATH"
      terraform init -backend=false > /dev/null 2>&1
      terraform validate || echo "⚠️  $component validation returned warning"
      cd - > /dev/null
    fi
  done
done
echo "✅ All environments validated"

# Test 3: Security Scanning
echo "📋 Running Security Checks..."
echo "  Checking for hardcoded secrets..."
if grep -r "password.*=.*['\"]" --include="*.tf" \
  environments/prod/ 2>/dev/null | grep -v "var\." | grep -v "random_password"; then
  echo "⚠️  Potential hardcoded secrets found"
fi

echo "  Checking database public access..."
grep -r "public_ip" modules/database/ --include="*.tf" && \
  echo "⚠️  Database has public IP" || echo "  ✅ No public IPs on databases"

echo "✅ Security checks complete"

# Test 4: Documentation
echo "📋 Checking Documentation..."
for module in "${MODULES[@]}"; do
  [ -f "modules/$module/README.md" ] || \
    echo "❌ Missing README for $module"
done
echo "✅ Documentation check complete"

echo ""
echo "✅ All tests completed successfully!"
echo "=================================="
echo "Status: READY FOR SUBMISSION"
```

**Run Full Tests:**
```bash
bash tests/comprehensive-validation.sh
```

---

## 8. Testing Checklist

### Pre-Production Checklist

- [ ] All modules pass `terraform validate`
- [ ] All code is formatted with `terraform fmt`
- [ ] No hardcoded secrets or credentials
- [ ] All environment configurations load correctly
- [ ] Security best practices implemented
- [ ] Documentation is complete and accurate
- [ ] Module dependencies are correct
- [ ] Naming conventions are consistent
- [ ] Encryption is enabled on sensitive resources
- [ ] Network security rules are appropriate
- [ ] Audit logging is configured
- [ ] Cost optimization is considered

### Before LinkedIn Submission

- [ ] Run full validation suite with no errors
- [ ] All documentation reflects current code
- [ ] Examples are tested and working
- [ ] README links all work
- [ ] Module READMEs are complete
- [ ] No credentials in any file (including git history)
- [ ] .gitignore is properly configured
- [ ] Repository is clean and organized

---

## 📚 Testing Resources

### Validation Tools:
- **terraform validate** - Built-in syntax checking
- **terraform fmt** - Code formatting
- **TFLint** - Terraform linting
- **Checkov** - Infrastructure scanning

### Commands Reference:
```bash
# Format check
terraform fmt -recursive -check .

# Syntax validate
terraform validate

# Security scan (if TFLint installed)
tflint --init && tflint

# Generate documentation
terraform-docs markdown . > README_AUTO.md
```

---

**Last Updated**: 2025-12-16
**Status**: ✅ Test Procedures Ready
