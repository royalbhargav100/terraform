#!/bin/bash

# This script runs terraform plan for all components in an environment

set -e

ENVIRONMENT=${1:-dev}

echo "Running terraform plan for environment: $ENVIRONMENT"

for component in environments/$ENVIRONMENT/*/; do
  if [ -f "${component}main.tf" ]; then
    echo "Planning: ${component%/}"
    cd "$component"
    terraform init
    terraform plan -out=tfplan
    cd - > /dev/null
  fi
done

echo "Plan complete!"
