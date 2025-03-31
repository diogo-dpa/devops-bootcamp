### AWS CLI Setup with SSO

1. Install AWS CLI on macOS using Homebrew:

```bash
brew install awscli
```

2. Configure AWS SSO:

```bash
aws configure sso
```

Follow the prompts:

- SSO start URL (https://your-domain.awsapps.com/start)
- SSO Region (e.g., us-east-1)
- Choose your SSO account and role
- CLI profile name (e.g., my-sso-profile)

3. Verify SSO login:

```bash
aws sso login --profile my-sso-profile
```

4. Set your default profile (optional):

```bash
export AWS_PROFILE=my-sso-profile
```

### Provider Configuration with SSO

Configure the AWS provider to use your SSO profile:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "my-sso-profile"
  region  = "us-east-1"
}
```

### Authentication Methods

The recommended authentication methods in order of preference:

- AWS SSO (for development and production)
- IAM Roles (for CI/CD)
- IAM Users (legacy, not recommended)

Note: AWS SSO provides temporary credentials that are automatically rotated and follows security best practices.

## References:

- [Installing AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS SSO Configuration](https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html)
- [AWS Provider Authentication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication)
