# --------------------------------------------------
# Naming and tags
# --------------------------------------------------

# module "..." means "run the Terraform in that folder and use its outputs".
# source is a relative path inside this repo.

module "naming" {
  source = "../../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "rg" # official abbreviation for resource group
  version_suffix = var.version_suffix
}

module "tags" {
  source = "../../../shared/tags"

  environment          = module.naming.environment
  owner                = var.owner
  cost_centre          = var.cost_centre
  application          = var.application
  data_classification  = var.data_classification
  criticality          = var.criticality
  additional_tags      = var.tags
}

# --------------------------------------------------
# Resource group
# --------------------------------------------------

# resource "TYPE" "LABEL" creates one Azure object.
# TYPE is the AzureRM resource. LABEL is a local nickname (this).

resource "azurerm_resource_group" "this" {
  name     = module.naming.name # e.g. wcc-sbx-hack-rg
  location = var.location       # usually uksouth
  tags     = module.tags.tags
}

# count = 1 creates the lock. count = 0 skips it.
# Ternary: condition ? value_if_true : value_if_false

resource "azurerm_management_lock" "this" {
  count = var.lock_enabled ? 1 : 0

  name       = "${module.naming.name}-lock"
  scope      = azurerm_resource_group.this.id # lock this group only
  lock_level = "CanNotDelete"                 # can still read and change; cannot delete
  notes      = var.lock_notes
}
