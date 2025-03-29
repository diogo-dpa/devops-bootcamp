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

### Resources

Resources are the most important element in the Terraform language. Each resource block describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records. Example:

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket"

  tags = {
    Environment = "Dev"
    Managed_by  = "Terraform"
  }
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

### Datasources

Data sources allow Terraform to read and query data from resources that exist outside of Terraform's management. This is useful when you need to reference external resources or get information from your infrastructure that wasn't created by Terraform. Example: Example:

```hcl
data "aws_vpc" "existing" {
  default = true
}

# Use the data source
resource "aws_subnet" "example" {
  vpc_id     = data.aws_vpc.existing.id
  cidr_block = "10.0.1.0/24"
}
```

## Main Commands

- `terraform validate` - Checks whether the configuration is syntactically valid and internally consistent
- `terraform init` - Initialize working directory and download providers
- `terraform plan` - Create an execution plan
- `terraform apply` - Apply changes to infrastructure
- `terraform apply -auto-approve` - Apply changes to infrastructure skiping the confirmation
- `terraform destroy` - Destroy previously created infrastructure
- `terraform apply -destroy` - Same as above
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

## Important File Concepts

- `terraform.tfstate`: It will have the final version of the applied structure.
- `terraform.tfstate.backup`: It will have on version before from the final version of the applied structure, in case it needs to revert it.

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
