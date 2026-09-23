# Tagging

`shared/tags` emits a baseline set and merges caller tags.

Baseline keys:

- Environment
- Owner
- CostCentre
- Application
- ManagedBy = Terraform
- DataClassification
- Criticality

Callers may add more keys. Callers may override Owner, CostCentre, Application, DataClassification and Criticality. ManagedBy stays Terraform.
