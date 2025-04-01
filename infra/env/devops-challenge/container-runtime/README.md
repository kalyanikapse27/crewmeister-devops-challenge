# Terraform to create VPC and EKS Cluster
This guide demonstrates how VPC, EKS Cluster and there sub-sequent resources created.

## Step 1️⃣: Update 1st terraform-backend-config
Add S3 bucket name in terraform-backend config in
([provider.tf](provider.tf))



  #### Initialize and Apply
  Run the following commands to initialize and apply the Terraform configuration where state file is safely stored in S3 bucket.

      # terraform init

      # terraform apply -auto-approve

  This will create the VPC and EKS Cluster.
