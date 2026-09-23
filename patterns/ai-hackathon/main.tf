# --------------------------------------------------
# Identity context
# Tenant ID is read at apply time. It is not stored in git.
# --------------------------------------------------

# data sources read existing information. They do not create resources.
# This one answers "who is signed in?" so Key Vault can use that tenant ID.

data "azurerm_client_config" "current" {}

# --------------------------------------------------
# Resource group
# --------------------------------------------------

# Reuse the resource-group building block instead of declaring azurerm_resource_group here.

module "rg" {
  source = "../../building-blocks/foundation/resource-group"

  location     = var.location
  environment  = var.environment
  description  = var.description
  company      = var.company
  owner        = var.owner
  cost_centre  = var.cost_centre
  application  = var.application
  tags         = var.tags
  lock_enabled = false # sandbox must stay easy to destroy
}

# --------------------------------------------------
# Minimum viable hackathon resources
# Replace these with building-block calls when those modules ship.
# --------------------------------------------------

resource "azurerm_storage_account" "this" {
  # Name comes from shared/naming. Azure forbids hyphens, so it looks like wccsbxhackstg01.
  name                            = module.name_stg.name
  resource_group_name             = module.rg.name
  location                        = module.rg.location
  account_tier                    = "Standard" # cheapest general-purpose tier
  account_replication_type        = "LRS"      # one datacentre copy; fine for throwaway data
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = var.public_network_access_enabled
  shared_access_key_enabled       = true  # Functions-style tools still expect a key
  allow_nested_items_to_be_public = false # no anonymous blob URLs
  tags                            = module.rg.tags
}

resource "azurerm_key_vault" "this" {
  name                          = module.name_kv.name
  location                      = module.rg.location
  resource_group_name           = module.rg.name
  # Tenant comes from the signed-in identity, not from a value in git.
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard" # Premium is HSM only; not needed here
  rbac_authorization_enabled    = true       # roles instead of vault access policies
  purge_protection_enabled      = false      # sandbox must be deletable
  soft_delete_retention_days    = 7          # minimum Azure allows
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = module.rg.tags
}

resource "azurerm_search_service" "this" {
  name                          = module.name_srch.name
  resource_group_name           = module.rg.name
  location                      = module.rg.location
  sku                           = var.search_sku # default basic; free is too small for RAG
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = true # API keys still work for a two-day event
  tags                          = module.rg.tags
}

resource "azurerm_cognitive_account" "foundry" {
  name                          = module.name_aif.name
  location                      = module.rg.location
  resource_group_name           = module.rg.name
  kind                          = "AIServices" # Foundry / multi-service account
  sku_name                      = var.foundry_sku
  custom_subdomain_name         = module.name_aif.name # required for private endpoint later
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = false
  tags                          = module.rg.tags

  # SystemAssigned: Azure creates an identity for this account. No password stored.
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_account" "openai" {
  name                          = module.name_oai.name
  location                      = module.rg.location
  resource_group_name           = module.rg.name
  kind                          = "OpenAI" # model deployments are created in the portal / Foundry UI
  sku_name                      = var.openai_sku
  custom_subdomain_name         = module.name_oai.name
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = false
  tags                          = module.rg.tags

  # SystemAssigned: Azure creates an identity for this account. No password stored.
  identity {
    type = "SystemAssigned"
  }
}

# --------------------------------------------------
# RAG extras
# count = 0 when mode is minimum, so these do not appear in the plan.
# this[0] means "the first (only) instance" because count was used.
# --------------------------------------------------

resource "azurerm_cognitive_account" "document_intelligence" {
  count = local.rag ? 1 : 0

  name                          = module.name_di.name
  location                      = module.rg.location
  resource_group_name           = module.rg.name
  kind                          = "FormRecognizer" # Azure resource kind for Document Intelligence
  sku_name                      = var.document_intelligence_sku
  custom_subdomain_name         = module.name_di.name
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = false
  tags                          = module.rg.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  count = local.rag ? 1 : 0

  name                = module.name_log.name
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = module.rg.tags
}

resource "azurerm_application_insights" "this" {
  count = local.rag ? 1 : 0

  name                = module.name_appi.name
  location            = module.rg.location
  resource_group_name = module.rg.name
  workspace_id        = azurerm_log_analytics_workspace.this[0].id # workspace-based Insights
  application_type    = "web"
  sampling_percentage = 20 # drop 80% of telemetry so ingest stays small
  tags                = module.rg.tags
}

resource "azurerm_user_assigned_identity" "this" {
  count = local.rag ? 1 : 0

  name                = module.name_id.name
  location            = module.rg.location
  resource_group_name = module.rg.name
  tags                = module.rg.tags
}

# IAM: principal_id is who, scope is what they may use, role is how much.

resource "azurerm_role_assignment" "openai_user" {
  count = local.rag ? 1 : 0

  scope                = azurerm_cognitive_account.openai.id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
}

resource "azurerm_role_assignment" "search_reader" {
  count = local.rag ? 1 : 0

  scope                = azurerm_search_service.this.id
  role_definition_name = "Search Index Data Reader"
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
}

resource "azurerm_role_assignment" "storage_blob_reader" {
  count = local.rag ? 1 : 0

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
}

resource "azurerm_role_assignment" "kv_secrets_user" {
  count = local.rag ? 1 : 0

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.this[0].principal_id
}
