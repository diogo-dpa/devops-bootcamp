## Prerequisites

### Azure CLI Setup

1. Install Azure CLI on macOS using Homebrew:

```bash
brew update && brew install azure-cli
```

2. Login to Azure:

```bash
az login
```

This will open your default browser to complete the authentication process.

3. Verify your login and subscription:

```bash
az account show
```

4. (Optional) If you have multiple subscriptions, set the one you want to use:

```bash
az account set --subscription "Your Subscription Name or ID"
```

### Provider Configuration

After logging in, configure the Azure provider in your Terraform code:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

### Authentication Methods

The Azure provider will automatically use the credentials from Azure CLI. However, you can also authenticate using:

- Service Principal with Client Certificate
- Service Principal with Client Secret
- Managed Service Identity
- OpenID Connect

For production environments, it's recommended to use Service Principal authentication instead of personal credentials.

## References:

- [How to Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
