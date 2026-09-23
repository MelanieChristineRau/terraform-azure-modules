# Choose your path

Start with the sentence that matches your week. Then open that folder.

## I need a whole environment

| Sentence | Folder | Status | Portal work this replaces |
|---|---|---|---|
| I need an AI hackathon or RAG sandbox this week | [patterns/ai-hackathon](../patterns/ai-hackathon/README.md) | Ready | Resource group, storage, Key Vault, Search, Foundry, OpenAI, budget, optional Doc Intelligence and logs |
| I need a simple public website | [patterns/simple-website](../patterns/simple-website/README.md) | Planned | App Service plan, web app, App Insights |
| I need somewhere to develop a web app | [patterns/web-development-environment](../patterns/web-development-environment/README.md) | Planned | VNet, app, storage, Key Vault, logs |
| I need a Drupal site with a database | [patterns/drupal-website](../patterns/drupal-website/README.md) | Planned | App Service, MySQL Flexible, Key Vault, storage |
| I need a Function / HTTP API | [patterns/serverless-api](../patterns/serverless-api/README.md) | Planned | Storage, Function App, App Insights |
| I need council integration / workflows | [patterns/logic-app-integration](../patterns/logic-app-integration/README.md) | Planned | Plan, storage, Logic App Standard, Key Vault |
| I need containers without Kubernetes | [patterns/containerised-web-application](../patterns/containerised-web-application/README.md) | Planned | ACR, Container Apps environment, app |

## I need one component

Use a building block when a pattern already exists and you only want to add one piece, or when you are writing a new pattern.

| Sentence | Folder | Status |
|---|---|---|
| I need a resource group with the right name and tags | [resource-group](../building-blocks/foundation/resource-group/README.md) | Ready |
| I need a managed identity | [managed-identity](../building-blocks/foundation/managed-identity/README.md) | Planned |
| I need a VNet / subnet / NSG / private endpoint | [networking](../building-blocks/networking/) | Planned |
| I need storage or Key Vault | [data](../building-blocks/data/) | Planned |
| I need a web app, Function or Logic App | [application](../building-blocks/application/) | Planned |
| I need Log Analytics or App Insights | [monitoring](../building-blocks/monitoring/) | Planned |
| I need Foundry, OpenAI or AI Search | [ai](../building-blocks/ai/) | Planned |

## I need the name to be right

Do not invent `wcc-sbx-something`. Call [shared/naming](../shared/naming/README.md).

```hcl
module "name" {
  source         = "../../shared/naming"
  environment    = "sbx"
  description    = "hack"
  resource_type  = "kv"
  version_suffix = "01"
}
# module.name.name == "wcc-sbx-hack-kv01"
```

Storage names drop hyphens automatically (`wccsbxhackstg01`). VM names stay under 15 characters or plan fails.

## First time here?

1. Read the [root README](../README.md) 10 minute start
2. Sign in with `az login`
3. Apply the AI hackathon pattern in sandbox
4. Come back to this page when you need a different job
