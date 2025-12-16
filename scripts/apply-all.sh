#!/bin/bash

# This script applies terraform configuration for all components in an environment

set -e

ENVIRONMENT=${1:-dev}

echo "Applying terraform for environment: $ENVIRONMENT"

for component in environments/$ENVIRONMENT/*/; do
  if [ -f "${component}main.tf" ]; then
    echo "Applying: ${component%/}"
    cd "$component"
    terraform init
    terraform apply -auto-approve tfplan || terraform apply -auto-approve
    cd - > /dev/null
  fi
done

echo "Apply complete!"
