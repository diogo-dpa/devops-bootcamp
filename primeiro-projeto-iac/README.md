# Terraform Learning Project

This project demonstrates key concepts of Infrastructure as Code (IaC) using Terraform to manage AWS resources.

## Main Concepts

### Providers

Providers are plugins that allow Terraform to interact with cloud platforms and other services. Example:

```hcl
provider "aws" {
  region  = "us-east-2"
  profile = "your-profile"
}
```

### Variables

Variables help make your Terraform code reusable and configurable. Example:

```hcl
variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}
```

### Modules

Modules are containers for multiple resources that are used together. Example:

```hcl
module "s3" {
  source        = "./modules/s3"
  s3_bucket_name = "my-bucket"
}
```

### Outputs

Outputs allow you to expose specific values that can be queried and used by other resources or modules:

```hcl
output "bucket_domain_name" {
  value       = aws_s3_bucket.bucket.bucket_domain_name
  description = "The domain name of the bucket"
}
```

## Main Commands

- `terraform init` - Initialize working directory and download providers
- `terraform plan` - Create an execution plan
- `terraform apply` - Apply changes to infrastructure
- `terraform destroy` - Destroy previously created infrastructure
- `terraform workspace list` - List available workspaces
- `terraform workspace new <name>` - Create a new workspace
- `terraform workspace select <name>` - Switch to a specific workspace

## Project Structure

```
.
├── main.tf           # Main configuration file
├── providers.tf      # Provider configurations
├── modules/
│   └── s3/          # S3 bucket module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

## Workspaces

This project uses Terraform workspaces to manage different environments:

- `dev` - Development environment
- `prod` - Production environment (when needed)

To switch between environments:

```bash
terraform workspace select dev
```

## References

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
