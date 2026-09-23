provider "azurerm" {
  features {}
}

module "rg" {
  source = "../.."

  location     = var.location
  environment  = var.environment
  description  = var.description
  owner        = var.owner
  cost_centre  = var.cost_centre
  application  = var.application
}

variable "location" { type = string }
variable "environment" { type = string }
variable "description" { type = string }
variable "owner" { type = string }
variable "cost_centre" { type = string }
variable "application" { type = string }

output "name" { value = module.rg.name }
output "id" { value = module.rg.id }
