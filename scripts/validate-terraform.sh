#!/bin/bash

# This script validates all Terraform configurations in the environments directory

set -e

echo "Validating Terraform configurations..."

for env in environments/*/; do
  for component in "$env"*/; do
    if [ -f "${component}main.tf" ]; then
      echo "Validating: ${component%/}"
      cd "$component"
      terraform init -backend=false
      terraform validate
      cd - > /dev/null
    fi
  done
done

echo "Validation complete!"
