# --------------------------------------------------
# Baseline tags
# --------------------------------------------------

# merge() combines two maps. The second merge pins ManagedBy so a caller
# cannot override it with additional_tags.

locals {
  baseline = {
    Environment        = var.environment
    Owner              = var.owner
    CostCentre         = var.cost_centre
    Application        = var.application
    ManagedBy          = "Terraform"
    DataClassification = var.data_classification
    Criticality        = var.criticality
  }

  merged               = merge(local.baseline, var.additional_tags)
  result               = merge(local.merged, { ManagedBy = "Terraform" })
}
