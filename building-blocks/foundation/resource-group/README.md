# Resource group

Status: implemented

Creates one resource group with the official WCC name and tags. Optional CanNotDelete lock. No budget. Budgets belong on the AI hackathon pattern only.

Portal equivalent: Home > Resource groups > Create, then Tags, then Locks.

Example name: `wcc-sbx-hack-rg`.

## When to use this

- You are writing a pattern and need a group to put things in
- You want a correctly named empty group in sandbox

If you want a working website or hackathon, start with a pattern instead. The pattern already calls this module.

## Use it

From a pattern:

```hcl
module "rg" {
  source = "../../building-blocks/foundation/resource-group"

  location     = "uksouth"
  environment  = "sbx"
  description  = "hack"
  owner        = "cloud-platform"
  cost_centre  = "IT"
  application  = "ai-hackathon"
}
```

Standalone test:

```bash
cd building-blocks/foundation/resource-group/examples/basic
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

## What you set

| Input | Required | Notes |
|---|---|---|
| `location` | yes | Usually `uksouth` |
| `environment` | yes | `sbx`, `dev`, `pre`, `prd`, `qas` |
| `description` | yes | Short workload name |
| `owner` | yes | Team or mailbox |
| `cost_centre` | yes | WCC cost centre |
| `application` | yes | Workload name for tags |
| `lock_enabled` | no | Default false. Turn on in production. |

## What you get

| Output | Meaning |
|---|---|
| `name` | `wcc-sbx-hack-rg` |
| `id` | Azure resource ID |
| `location` | Region |
| `tags` | Baseline tag map |
| `environment` | Normalised code (`prd` not `prod`) |

## Destroy

```bash
terraform destroy
```

If a lock was enabled, set `lock_enabled = false`, apply, then destroy.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
