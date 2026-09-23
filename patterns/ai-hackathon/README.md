# AI Hackathon

Status: implemented

One apply gives a sandbox that a two-day AI event can actually use. This is the fastest path in the repository.

Portal equivalent: create a resource group, storage account, Key Vault, AI Search, AI Foundry, Azure OpenAI, a budget, then (for RAG) Document Intelligence, Log Analytics, App Insights, a managed identity and four role assignments. That is a long afternoon. This pattern is a plan and an apply.

This is the only place in the repository that creates a budget.

## Pick a mode

`minimum` (default) is enough to call models and store files.

`rag` adds document ingestion, logs and an identity that can read those services.

| Resource | Name you get | minimum | rag |
|---|---|---|---|
| Resource group | `wcc-sbx-hack-rg` | yes | yes |
| Storage Standard LRS | `wccsbxhackstg01` | yes | yes |
| Key Vault Standard | `wcc-sbx-hack-kv01` | yes | yes |
| AI Search Basic | `wcc-sbx-hack-srch01` | yes | yes |
| AI Foundry (AIServices) | `wcc-sbx-hack-aif01` | yes | yes |
| Azure OpenAI | `wcc-sbx-hack-oai01` | yes | yes |
| Resource group budget | `wcc-sbx-hack-budget` | yes | yes |
| Document Intelligence F0 | `wcc-sbx-hack-di01` | | yes |
| Log Analytics 30 days | `wcc-sbx-hack-log01` | | yes |
| Application Insights | `wcc-sbx-hack-appi01` | | yes |
| User assigned identity | `wcc-sbx-hack-id01` | | yes |

Search defaults to Basic. Free is 50 MB and weak on identity and private networking. Vector search exists on all tiers.

Copilot Studio and Power Platform are licences. They are not created here.

## Run it

```bash
az login
cd patterns/ai-hackathon
cp terraform.tfvars.example terraform.tfvars
```

Edit three values in `terraform.tfvars`:

```hcl
owner       = "your-team"
cost_centre = "IT"
budget_contact_emails = ["you@westminster.gov.uk"]
mode        = "minimum"   # or "rag"
```

Then:

```bash
terraform init -backend-config=../../backends/sbx.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

From the repo root: `make plan` then `make apply`.

Replace the placeholder storage account names in `backends/sbx.hcl` with the real WCC tfstate account before the first apply.

No secrets belong in this folder. `tenant_id` for Key Vault is read from your signed-in identity at apply time.

## After apply

1. Open the resource group `wcc-sbx-hack-rg` in the portal to confirm the set
2. Deploy a model in the OpenAI or Foundry account (model choice is a product decision, not Terraform)
3. Watch budget emails at 50, 80 and 100 percent
4. Destroy when the event ends. Do not leave pay-as-you-go models running

```bash
terraform destroy
```

Sandbox subscriptions may delete resource groups after 30 days. That is not a substitute for destroy. Model usage still bills until the accounts are gone.

## Cost notes

The `budget_amount` default is 150 in subscription currency. That is a tripwire, not a quote. Check the Azure pricing calculator before the event and date any pound figures in the event runbook. Do not put prices in `.tf` files.

## How this is built

The resource group comes from the `resource-group` building block. Names come from `shared/naming`. Storage, Key Vault, Search and cognitive accounts are still declared in this pattern until those building blocks exist. When they ship, this folder will call them instead. The names will not change.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
