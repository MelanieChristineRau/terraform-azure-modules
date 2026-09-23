# Naming

Status: implemented

Every WCC Azure name is built here. Building blocks call this module so engineers never type `wcc-sbx-hack-kv01` by hand.

Portal equivalent: the Name box on every create blade, plus the official WCC naming page.

## What you pass

| Input | Example | Meaning |
|---|---|---|
| `company` | `wcc` | Organisation prefix. Leave the default. |
| `environment` | `sbx` | `prd`, `pre`, `qas`, `dev`, `sbx` or an alias such as `prod` / `preprod` / `sandbox` |
| `description` | `hack` | Short lowercase workload name |
| `resource_type` | `kv` | Official abbreviation, or `vm` |
| `version_suffix` | `01` | Optional instance. Empty is fine. |

## What you get

| Inputs | `name` output |
|---|---|
| sbx + hack + rg | `wcc-sbx-hack-rg` |
| sbx + hack + kv + 01 | `wcc-sbx-hack-kv01` |
| sbx + hack + stg + 01 | `wccsbxhackstg01` |
| sbx + hack + srch + 01 | `wcc-sbx-hack-srch01` |
| dev + web + vm + 01 | `wccdevweb01` |

Storage and Container Registry names cannot contain hyphens. The module strips them. Virtual machine names cannot go over 15 characters. Plan fails if they would.

Unknown environments fail plan. `prod` becomes `prd`. `sandbox` becomes `sbx`.

## Use it

```hcl
module "kv_name" {
  source         = "../../shared/naming"
  environment    = var.environment
  description    = var.description
  resource_type  = "kv"
  version_suffix = "01"
}

resource "azurerm_key_vault" "this" {
  name = module.kv_name.name
  # ...
}
```

You almost never call this from a laptop as a standalone apply. Patterns and building blocks call it for you.

Full abbreviation table: [docs/naming.md](../../docs/naming.md).

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
