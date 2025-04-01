# Terraform Backend Setup Guide

This guide demonstrates how to initialize Terraform using a local backend for the first run and then migrate to an AWS S3 backend for persistent state storage with S3 native locking.

## Step 1️⃣: Initialize with Local Backend (First Run)

For the first run, use local storage to store Terraform state before switching to S3.

### Initialize and Apply (Using Local State)

Run the following commands to initialize and apply the Terraform configuration with local state

      # terraform init

      # terraform apply -auto-approve

This will create the S3 bucket AWS.

## Step 2️⃣: Migrate State to AWS S3

After the resources are created, update Terraform to use S3 for remote state storage.
Update the main.tf to replace the local backend with the S3 backend configuration.

    Step 1️⃣ Modify provider.tf to Use S3 Backend

        terraform {
          backend "s3" {
            bucket         = "devops-challenge-test-terraform-backend"
            key            = "dev/devops-challenge-test-terraform-backend/terraform.tfstate"
            region         = "us-east-1"
            use_lockfile   = true
            encrypt        = true
           }
        }

    Step 2️⃣ Migrate the State to S3

        # terraform init -migrate-state

    Step 3️⃣: Verify the Migration
    Run the following command to check the state list after migration:

        # terraform state list

    Step 4️⃣: Continue Using Remote State

        # terraform plan
        # terraform apply
    Terraform will now securely store state in S3 bucket with native state locking method. This helps for state locking to avoid race conditions during concurrent operations.
