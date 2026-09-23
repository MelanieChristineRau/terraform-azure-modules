# --------------------------------------------------
# Cost control
# Lives in this pattern only. Do not promote into building-blocks.
# --------------------------------------------------

# A budget watches spend on this resource group and emails at 50%, 80% and 100%.
# It does not stop resources by itself. Someone still has to act on the email.

resource "azurerm_consumption_budget_resource_group" "this" {
  name              = module.name_budget.name
  resource_group_id = module.rg.id

  amount     = var.budget_amount # tripwire in subscription currency, not a quote
  time_grain = "Monthly"

  time_period {
    start_date = var.budget_start_date # first day of the month, RFC3339
  }

  notification {
    enabled        = true
    threshold      = 50.0
    operator       = "GreaterThan"
    threshold_type = "Actual" # already spent
    contact_emails = var.budget_contact_emails
  }

  notification {
    enabled        = true
    threshold      = 80.0
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.budget_contact_emails
  }

  notification {
    enabled        = true
    threshold      = 100.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted" # Azure thinks you will hit the amount
    contact_emails = var.budget_contact_emails
  }
}
