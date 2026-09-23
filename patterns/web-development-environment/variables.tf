variable "location" {
  type        = string
  description = "Azure region. Example: uksouth."
}

variable "environment" {
  type        = string
  default     = "sbx"
  description = "WCC environment designation or alias."
}

variable "description" {
  type        = string
  description = "Short lowercase workload name."
}
