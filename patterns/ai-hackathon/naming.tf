# Each block below asks shared/naming for one official name.
# resource_type picks the abbreviation (stg, kv, srch, ...).
# We call the module several times because each resource needs a different name.

module "name_stg" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "stg"
  version_suffix = "01"
}

module "name_kv" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "kv"
  version_suffix = "01"
}

module "name_srch" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "srch"
  version_suffix = "01"
}

module "name_aif" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "aif"
  version_suffix = "01"
}

module "name_oai" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "oai"
  version_suffix = "01"
}

module "name_di" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "di"
  version_suffix = "01"
}

module "name_log" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "log"
  version_suffix = "01"
}

module "name_appi" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "appi"
  version_suffix = "01"
}

module "name_id" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "id"
  version_suffix = "01"
}

module "name_budget" {
  source = "../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "budget"
  version_suffix = ""
}
