# Inputs for this building block. A pattern passes these in.
# description is required so terraform-docs and TFLint can document them.

variable "location" {
  type        = string
  description = "Azure region. Example: uksouth."
}

variable "environment" {
  type        = string
  description = "WCC environment designation or alias. Example: sbx."
}

variable "description" {
  type        = string
  description = "Short lowercase workload name. Example: hack."
}

variable "version_suffix" {
  type        = string
  default     = ""
  description = "Optional version suffix. Resource groups usually omit this."
}

variable "company" {
  type        = string
  default     = "wcc"
  description = "Organisation prefix."
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
  description = "Application or workload name."
}

variable "data_classification" {
  type        = string
  default     = "Official"
  description = "Data classification label."
}

variable "criticality" {
  type        = string
  default     = "Low"
  description = "Business criticality."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags."
}

variable "lock_enabled" {
  type        = bool
  default     = false
  description = "Create a CanNotDelete management lock. Off by default."
}

variable "lock_notes" {
  type        = string
  default     = "WCC Terraform resource group lock"
  description = "Notes stored on the optional management lock."
}
