module "vm" {
  source = "../.."

  location            = var.location
  resource_group_name = var.resource_group_name
  environment         = var.environment
  description         = var.description
  version_suffix      = var.version_suffix
  owner               = var.owner
  cost_centre         = var.cost_centre
  application         = var.application
  subnet_id           = var.subnet_id
  admin_password      = var.admin_password
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "resource_group_name" { type = string }
variable "environment" { type = string }
variable "description" { type = string }
variable "version_suffix" {
  type    = string
  default = "01"
}
variable "owner" { type = string }
variable "cost_centre" { type = string }
variable "application" { type = string }
variable "subnet_id" { type = string }
variable "admin_password" {
  type      = string
  sensitive = true
}