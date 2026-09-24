# Inputs a pattern or example passes in.
# The VM name is built from environment + description + version_suffix and must stay under 15 characters.

variable "location" {
  type        = string
  description = "Azure region. Example: uksouth."
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group to put the VM in."
}

variable "environment" {
  type        = string
  description = "WCC environment designation or alias. Example: sbx."
}

variable "description" {
  type        = string
  description = "Short lowercase workload name. Keep it short. VM names cannot exceed 15 characters."
}

variable "version_suffix" {
  type        = string
  default     = "01"
  description = "Instance suffix. Official compute pattern: wccsbxjump01."
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

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the NIC. The VNet and subnet already exist."
}

variable "admin_username" {
  type        = string
  default     = "wccadmin"
  description = "Local administrator. Cannot be Administrator or admin."
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Local administrator password. Do not put this in git. Use tfvars locally or Key Vault later."
}

variable "size" {
  type        = string
  default     = "Standard_B2s"
  description = "VM size. B2s is a small sandbox default."
}

variable "os_disk_type" {
  type        = string
  default     = "StandardSSD_LRS"
  description = "OS disk SKU. Premium_LRS if the size requires it."
}

variable "timezone" {
  type        = string
  default     = "GMT Standard Time"
  description = "Windows timezone name."
}

variable "image_publisher" {
  type        = string
  default     = "MicrosoftWindowsServer"
  description = "Marketplace publisher."
}

variable "image_offer" {
  type        = string
  default     = "WindowsServer"
  description = "Marketplace offer."
}

variable "image_sku" {
  type        = string
  default     = "2022-datacenter-azure-edition"
  description = "Marketplace SKU."
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "Marketplace image version."
}

variable "allow_rdp_from_cidr" {
  type        = string
  default     = ""
  description = "Optional source CIDR for RDP (3389) on the NIC NSG. Empty means no inbound RDP. Prefer Bastion."
}