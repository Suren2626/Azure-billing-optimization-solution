#!/bin/bash

# Deploy infrastructure
echo "Deploying Azure resources..."
terraform init
terraform apply -auto-approve

# Set up Function App code & configuration
echo "Deploying Azure Functions..."
cd functions
func azure functionapp publish my-billing-functions --python

echo "Deployment complete."
