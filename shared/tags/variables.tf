variable "environment" {
  type        = string
  description = "Normalised or raw environment code. Stored in the Environment tag."
}

variable "owner" {
  type        = string
  description = "Service or team mailbox that owns the resource."
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
  description = "Business criticality. Example: Low, Medium, High."
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags merged on top of the baseline. Cannot override ManagedBy."
}
