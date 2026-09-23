# --------------------------------------------------
# Remote state
# "Backend" means where Terraform stores its inventory of created resources.
# The empty block says "Azure Storage, details later".
# Pass backends/sbx.hcl (or dev/pre/prd) at init time so no account name
# is hardcoded in this folder.
# --------------------------------------------------

terraform {
  backend "azurerm" {}
}
