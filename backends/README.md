# Remote state

Terraform state is not stored in git. Each environment has its own state file in Azure Storage.

Portal equivalent: none. This is the thing the portal never did for you, which is why two people could change the same resource group at once.

## How to use

```bash
cd patterns/ai-hackathon
terraform init -backend-config=../../backends/sbx.hcl
```

| File | State key |
|---|---|
| `sbx.hcl` | `ai-hackathon/sbx/terraform.tfstate` |
| `dev.hcl` | `ai-hackathon/dev/terraform.tfstate` |
| `pre.hcl` | `ai-hackathon/pre/terraform.tfstate` |
| `prd.hcl` | `ai-hackathon/prd/terraform.tfstate` |

`use_azuread_auth = true` so there is no storage account key in the file. Your `az login` or pipeline identity needs Blob Data access on that account.

The storage account names in these files are placeholders. Replace them with the real WCC tfstate accounts before the first apply. Do not commit a personal account.

Building-block folders have no backend. They are modules. Only patterns and examples are applied.
