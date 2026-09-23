# Pin Terraform and the Azure plugin so a new release cannot change this pattern overnight.
terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

# No credentials here. Azure CLI / OIDC / managed identity supply them at apply time.
# The feature flags below are sandbox-friendly: a destroy can remove a vault and a
# non-empty resource group instead of leaving orphaned objects behind.
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
