# Operating practices

These rules exist because configuration mistakes delete production systems. Treat them as required, not style.

## Keep the blast radius small

This repository is a catalogue of building blocks and patterns. It is not one giant apply for the whole estate.

- A pattern is one environment for one workload
- Networking that rarely changes should live in its own state, not inside an app pattern
- A bug in `patterns/ai-hackathon` must not be able to rewrite a shared hub VNet

Do not copy the same `.tf` tree into `dev/`, `pre/` and `prd/` folders. One pattern, many state files.

## Strict versioning

Pin both Terraform and providers. Do not float on latest.

```hcl
terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}
```

When building blocks start to be consumed across repos, pin `source` to a git tag. Relative `source = "../../building-blocks/..."` is acceptable only inside this repository.

## Use modules

Reusable WCC standards live in `building-blocks/` and `shared/`. Patterns compose those modules. Do not paste a raw `azurerm_resource_group` into every new workload once the building block exists.

## Never store state in git

State can contain secrets in plain text. `.gitignore` already blocks `*.tfstate` and `*.tfstate.*`. If a state file is committed, treat it as a credential leak.

## Remote state and locking

Root modules (patterns and examples) use an Azure Storage backend with blob lease locking. Building-block folders are modules. They are not applied on their own, so they have no backend.

Partial backend config is committed. Real storage account names are passed at init:

```bash
terraform init -backend-config=backends/sbx.hcl
```

See `backends/` and `patterns/ai-hackathon/backend.tf`.

## One state file per environment

| Environment | Backend key example |
|---|---|
| sbx | `ai-hackathon/sbx/terraform.tfstate` |
| dev | `ai-hackathon/dev/terraform.tfstate` |
| pre | `ai-hackathon/pre/terraform.tfstate` |
| prd | `ai-hackathon/prd/terraform.tfstate` |

Do not put sbx and prd in the same state. Workspaces are an alternative. Separate backend keys are clearer for WCC.

## Plan before apply

Always:

```bash
terraform plan -out=tfplan
# review the plan
terraform apply tfplan
```

`make plan` and `make apply` wrap that for the AI Hackathon pattern. CI should publish the plan and apply only the saved plan file. Never `terraform apply` without a reviewed plan in production.

## Never edit state by hand

State is a Terraform API artefact. If resources must move:

```bash
terraform import ...
terraform state mv ...
terraform state rm ...
```

Do not open the JSON in an editor.
