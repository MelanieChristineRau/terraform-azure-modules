variable "location" {
  type        = string
  description = "Azure region. Example: uksouth."
}

variable "environment" {
  type        = string
  description = "WCC environment designation or alias. Example: sbx, dev, pre, prd, qas."
}

variable "description" {
  type        = string
  description = "Short lowercase workload name used in the official naming pattern."
}

variable "version_suffix" {
  type        = string
  default     = ""
  description = "Optional version or instance suffix from the WCC naming standard."
}

variable "resource_group_name" {
  type        = string
  default     = null
  description = "Existing resource group name when this block does not create one."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags merged with the WCC baseline."
}
