# Tags

Status: implemented

Builds the tag map every WCC resource should carry. Building blocks merge this onto the Azure resource.

Portal equivalent: the Tags tab on every create blade, which people skip.

## What you pass

| Input | Example |
|---|---|
| `environment` | `sbx` |
| `owner` | `cloud-platform` |
| `cost_centre` | `IT` |
| `application` | `ai-hackathon` |
| `data_classification` | `Official` (default) |
| `criticality` | `Low` (default) |
| `additional_tags` | extra map if needed |

## What you get

```hcl
{
  Environment        = "sbx"
  Owner              = "cloud-platform"
  CostCentre         = "IT"
  Application        = "ai-hackathon"
  ManagedBy          = "Terraform"
  DataClassification = "Official"
  Criticality        = "Low"
}
```

`ManagedBy` is always `Terraform`. Extra tags cannot override it.

## Use it

```hcl
module "tags" {
  source      = "../../shared/tags"
  environment = "sbx"
  owner       = "cloud-platform"
  cost_centre = "IT"
  application = "ai-hackathon"
}

resource "azurerm_resource_group" "this" {
  tags = module.tags.tags
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
