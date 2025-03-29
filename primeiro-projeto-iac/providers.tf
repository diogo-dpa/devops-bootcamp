terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.93.0"
    }
  }
 
  # Once setup, the backend block will be used to store the Terraform state file in S3
  # It needs to run "terraform init" to initialize the backend
  backend "s3" {
    bucket = "rocketseat-state-bucket-tf-diogo"
    region = "us-east-2"
    key = "terraform.tfstate" ## Name of the state file
    encryption = true
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "AdministratorAccess-980110366124"
}

# This is the S3 bucket that will be used to store the Terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = ${var.state_bucket}
  
  lifecycle {
    prevent_destroy = true # Prevents accidental deletion of the bucket
  }
}