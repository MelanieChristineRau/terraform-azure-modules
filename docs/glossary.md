# What each tool is for

Read this once if you are new to Terraform. Then ignore it until something fails.

| Name | One sentence |
|---|---|
| Terraform | Describes Azure resources in files, then creates or changes them to match. |
| `azurerm` provider | The plugin that talks to Azure. Pin the version so a new release cannot change behaviour overnight. |
| Module / building block | A reusable folder of Terraform. You call it instead of copy-pasting resources. |
| Pattern | A ready-made environment that calls several building blocks. |
| `terraform init` | Downloads providers and modules. Run it once per folder, and again after versions change. |
| `terraform plan` | Shows what would change. Does not change Azure. Always read this. |
| `terraform apply` | Makes the plan real. In this repo you apply a saved `tfplan` file, not a live guess. |
| `terraform destroy` | Deletes everything this folder created. |
| `terraform fmt` | Rewrites `.tf` files to one official layout. No settings. |
| `terraform validate` | Checks the files are syntactically valid. Does not talk to Azure. |
| TFLint | A linter. Catches unused variables, missing descriptions, and common Azure mistakes before plan. |
| terraform-docs | Reads `variables.tf` / `outputs.tf` and writes tables into the README so docs cannot drift. |
| pre-commit | Runs fmt, TFLint, docs and validate on your laptop when you `git commit`. |
| Remote state | The live inventory of what Terraform created. Stored in Azure Storage, never in git. |
| Backend | Tells Terraform *where* to store that state. `backends/sbx.hcl` is sandbox, `prd.hcl` is production. |
| `terraform.tfvars` | Your values (owner, emails). Not committed. Copy from `terraform.tfvars.example`. |
| `data.azurerm_client_config` | Reads who you are signed in as at apply time. That is how Key Vault gets a tenant ID without putting it in git. |

More detail: [tooling.md](tooling.md), [practices.md](practices.md), [authentication.md](authentication.md).
