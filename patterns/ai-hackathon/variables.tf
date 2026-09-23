# Values you change in terraform.tfvars. Defaults are sandbox-safe.
# Variables without a default (owner, cost_centre, emails, budget start) must be set.

variable "location" {
  type        = string
  default     = "uksouth"
  description = "Azure region for the hackathon environment."
}

variable "environment" {
  type        = string
  default     = "sbx"
  description = "WCC environment designation or alias. Hackathons should use sbx."
}

variable "description" {
  type        = string
  default     = "hack"
  description = "Short lowercase workload name used in resource names."
}

variable "company" {
  type        = string
  default     = "wcc"
  description = "Organisation prefix."
}

variable "mode" {
  type        = string
  default     = "minimum"
  description = "minimum creates Foundry, OpenAI, Search, Storage, Key Vault and a budget. rag adds Document Intelligence, Log Analytics, Application Insights and a user assigned identity."

  validation {
    condition     = contains(["minimum", "rag"], var.mode)
    error_message = "mode must be minimum or rag."
  }
}

variable "owner" {
  type        = string
  description = "Owning team or mailbox."
}

variable "cost_centre" {
  type        = string
  description = "WCC cost centre or service code."
}

variable "application" {
  type        = string
  default     = "ai-hackathon"
  description = "Application tag."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags."
}

variable "search_sku" {
  type        = string
  default     = "basic"
  description = "Azure AI Search SKU. Basic is the hackathon default. Free is capacity and identity limited."
}

variable "openai_sku" {
  type        = string
  default     = "S0"
  description = "Azure OpenAI cognitive account SKU."
}

variable "foundry_sku" {
  type        = string
  default     = "S0"
  description = "AI Foundry (AIServices) SKU."
}

variable "document_intelligence_sku" {
  type        = string
  default     = "F0"
  description = "Document Intelligence SKU used when mode is rag."
}

variable "log_retention_days" {
  type        = number
  default     = 30
  description = "Log Analytics retention used when mode is rag."
}

variable "budget_amount" {
  type        = number
  default     = 150
  description = "Monthly resource-group consumption budget amount in the subscription currency. Check the Azure pricing calculator before the event. Do not treat this default as a quote."
}

variable "budget_start_date" {
  type        = string
  description = "Budget period start, RFC3339. Use the first day of the month. Example: 2026-09-01T00:00:00Z."
}

variable "budget_contact_emails" {
  type        = list(string)
  description = "Email addresses that receive budget alerts at 50, 80 and 100 percent."

  validation {
    condition     = length(var.budget_contact_emails) > 0
    error_message = "Provide at least one budget contact email."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Public network access for sandbox hackathon resources. Set false only when private networking is available."
}
