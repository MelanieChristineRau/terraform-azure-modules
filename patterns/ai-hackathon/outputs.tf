# terraform output prints these after apply.

output "resource_group_name" {
  description = "Hackathon resource group name."
  value       = module.rg.name
}

output "resource_group_id" {
  description = "Hackathon resource group ID."
  value       = module.rg.id
}

output "storage_account_name" {
  description = "Storage account name (hyphens stripped per Azure rules)."
  value       = azurerm_storage_account.this.name
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = azurerm_key_vault.this.name
}

output "search_name" {
  description = "Azure AI Search name."
  value       = azurerm_search_service.this.name
}

output "foundry_name" {
  description = "AI Foundry (AIServices) account name."
  value       = azurerm_cognitive_account.foundry.name
}

output "openai_name" {
  description = "Azure OpenAI account name."
  value       = azurerm_cognitive_account.openai.name
}

output "document_intelligence_name" {
  description = "Document Intelligence account name when mode is rag."
  value       = try(azurerm_cognitive_account.document_intelligence[0].name, null)
}

output "budget_name" {
  description = "Resource group consumption budget name."
  value       = azurerm_consumption_budget_resource_group.this.name
}

output "mode" {
  description = "Deployed hackathon mode."
  value       = var.mode
}
