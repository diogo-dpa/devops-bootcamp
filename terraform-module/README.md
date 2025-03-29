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

## Advanced Commands

- `terraform plan --destroy --target module.s3.aws_s3_bucket_website_configuration.bucket` - Creates a plan to destroy a specific resource (in this case, the S3 bucket website configuration) within a module without destroying the entire infrastructure. Useful for targeted resource removal or troubleshooting.
- `terraform destroy --target module.s3.aws_s3_bucket_website_configuration.bucket` - Destroy a specific resource within a module without destroying the entire infrastructure.
- `terraform apply -destroy --target module.s3.aws_s3_bucket_website_configuration.bucket` - Same as above.

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

### Variable Files (.tfvars)

Terraform variable definition files (`.tfvars`) allow you to set values for defined variables in separate files. This is useful for managing different environments or keeping sensitive values out of your main configuration. When exists, it overwrites the default value. Example:

```hcl
// filepath: terraform.tfvars
environment     = "production"
s3_bucket_name  = "my-production-bucket"
region          = "us-east-1"
instance_type   = "t3.micro"
```

You can have multiple `.tfvars` files:

- `terraform.tfvars` - Automatically loaded
- `*.auto.tfvars` - Automatically loaded
- Custom named files (loaded with `-var-file` flag)

Usage example:

```bash
# Load specific variable file
terraform plan -var-file="production.tfvars"

# Override specific variables
terraform apply -var="environment=staging"
```

Best Practices:

- Keep sensitive values in `.tfvars` files
- Add `.tfvars` files to `.gitignore` (except example files)
- Use different `.tfvars` files for different environments

## Workspaces

This project uses Terraform workspaces to manage different environments:

- `dev` - Development environment
- `prod` - Production environment (when needed)

To switch between environments:

```bash
terraform workspace select dev
```

### Backend Configuration

Backends in Terraform determine where and how the state file is stored. By default, Terraform uses local backend (stores state file locally), but for team collaboration and better security, remote backends are recommended. Example:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
```

Common backend types:

- `local` - Stores state file on local disk
- `s3` - Stores state in AWS S3 bucket
- `azurerm` - Stores state in Azure Storage
- `gcs` - Stores state in Google Cloud Storage
- `remote` - Stores state in Terraform Cloud/Enterprise

Benefits:

- **State Locking**: Prevents concurrent state modifications
- **Remote Storage**: Enables team collaboration
- **Encryption**: Secures sensitive data
- **Versioning**: Maintains state file history

Best Practices:

- Always use remote backends in production
- Enable encryption for sensitive data
- Use state locking to prevent conflicts
- Keep backend configuration in a separate file

## References

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Google Cloud Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
