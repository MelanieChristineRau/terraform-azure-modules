# Outputs are values this module hands back to the caller.
# module.naming.name in another file reads the "name" output below.

output "name" {
  description = "WCC-compliant resource name."
  value       = local.result
}

output "environment" {
  description = "Normalised official environment code (prd, pre, qas, dev, sbx)."
  value       = local.environment
}

output "resource_type" {
  description = "Abbreviation used in the name."
  value       = local.resource_type
}

output "style" {
  description = "Naming style applied: hyphenated, stripped or vm."
  value       = local.style
}
