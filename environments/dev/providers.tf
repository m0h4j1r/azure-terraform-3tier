terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }

  # Remote backend — stores state in Azure Blob Storage.
  # Populate the values below or pass them via -backend-config flags.
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate<unique_suffix>"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  # Credentials are injected via environment variables:
  #   ARM_CLIENT_ID, ARM_CLIENT_SECRET,
  #   ARM_SUBSCRIPTION_ID, ARM_TENANT_ID
}
