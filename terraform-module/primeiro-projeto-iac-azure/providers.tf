terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.25.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  skip_provider_registration = true
  features {

    # Prevent accidental deletion of the resource group
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}