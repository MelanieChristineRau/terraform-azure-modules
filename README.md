# WCC Azure building blocks

Build the Azure things WCC engineers create every week, without clicking through the portal for twenty minutes per resource.

You do not start from a raw Terraform resource list. You pick a job.

| I want to... | Open this | Ready now? |
|---|---|---|
| Stand up an AI hackathon / RAG sandbox in one apply | [patterns/ai-hackathon](patterns/ai-hackathon/README.md) | Yes |
| Create one correctly named resource group | [building-blocks/foundation/resource-group](building-blocks/foundation/resource-group/README.md) | Yes |
| Get an official WCC resource name | [shared/naming](shared/naming/README.md) | Yes |
| Build a website, Drupal, Functions, Logic Apps, or containers | [Choose your path](docs/choose-your-path.md) | Patterns are scaffolded |

The portal makes you name the resource, pick a region, remember tags, remember SKUs, then remember to add a budget. A pattern does that set of decisions once.

## 10 minute start (AI hackathon)

You need Azure CLI access to a sandbox subscription. No passwords go in this repo.

```bash
az login
git clone <this-repo>
cd wcc-azure-building-blocks

cp patterns/ai-hackathon/terraform.tfvars.example patterns/ai-hackathon/terraform.tfvars
# set owner, cost_centre and budget_contact_emails

make plan
# read the plan. You should see a resource group, storage, Key Vault,
# AI Search, Foundry, OpenAI and a budget.

make apply
```

What you get named for you:

| Resource | Name |
|---|---|
| Resource group | `wcc-sbx-hack-rg` |
| Storage | `wccsbxhackstg01` |
| Key Vault | `wcc-sbx-hack-kv01` |
| AI Search | `wcc-sbx-hack-srch01` |
| AI Foundry | `wcc-sbx-hack-aif01` |
| Azure OpenAI | `wcc-sbx-hack-oai01` |

Change `description` or `environment` in `terraform.tfvars` and the names change with the WCC standard. You do not type the names.

Set `mode = "rag"` when you also need Document Intelligence, logs and a managed identity.

Tear it down when the event ends: `terraform -chdir=patterns/ai-hackathon destroy`.

## How the repo is organised

```text
docs/               how to choose a path, naming, auth, state, tooling
shared/naming       official WCC names
shared/tags         official tags
building-blocks/    one reusable component (resource group, web app, VNet)
patterns/           a whole environment made from building blocks
backends/           remote state per environment (sbx, dev, pre, prd)
examples/           pointers to working examples
```

Think of it like this:

- **Building block** = one thing you would create in the portal (a Key Vault, a web app)
- **Pattern** = the set of portal clicks you actually wanted (a Drupal site, a hackathon)

Patterns call building blocks. You almost never apply a building block on its own except when you are testing it.

New to Terraform? [docs/glossary.md](docs/glossary.md) is one sentence per tool (plan, apply, TFLint, state, backend).

## What you do not put in git

- Passwords, keys, tenant IDs, subscription IDs, service principals
- `terraform.tfvars` (use `terraform.tfvars.example`)
- `*.tfstate` (remote state in Azure Storage, one file per environment)

Sign in with `az login`, GitHub OIDC or a managed identity. The provider block is empty on purpose. Details: [docs/authentication.md](docs/authentication.md).

## Rules that stop production accidents

Read [docs/practices.md](docs/practices.md) before you apply anything near production.

Short version:

1. Keep each apply small. One pattern, one workload.
2. Pin Terraform and provider versions.
3. Plan, read the plan, apply that plan file. Never apply blind.
4. One remote state file per environment.
5. Never edit state in a text editor. Use `import`, `state mv`, `state rm`.

## If you are adding a new building block

1. Copy an implemented folder such as `building-blocks/foundation/resource-group`
2. Call `shared/naming` and `shared/tags`
3. Write the README in the same shape as this one: what it is, portal equivalent, copy-paste example, destroy notes
4. Run `make docs` so the catalogue below updates

Full contributor notes: [CONTRIBUTING.md](CONTRIBUTING.md).

## Tooling

```bash
make fmt         # terraform fmt (the only style rule)
make validate    # implemented modules
make lint        # tflint
make docs        # refresh README input tables and this catalogue
make check       # all of the above
make plan        # hackathon pattern, writes tfplan
make apply       # applies tfplan only
```

More: [docs/tooling.md](docs/tooling.md).

## Catalogue

<!-- BEGIN_CATALOGUE -->
### Shared helpers
| Name | Path | Status |
|---|---|---|
| `naming` | `shared/naming` | implemented |
| `tags` | `shared/tags` | implemented |

### Building blocks
| Name | Path | Status |
|---|---|---|
| `ai-search` | `building-blocks/ai/ai-search` | planned |
| `cognitive-account` | `building-blocks/ai/cognitive-account` | planned |
| `app-service-plan` | `building-blocks/application/app-service-plan` | planned |
| `container-app` | `building-blocks/application/container-app` | planned |
| `container-registry` | `building-blocks/application/container-registry` | planned |
| `function-app` | `building-blocks/application/function-app` | planned |
| `logic-app-standard` | `building-blocks/application/logic-app-standard` | planned |
| `web-app` | `building-blocks/application/web-app` | planned |
| `linux-vm` | `building-blocks/compute/linux-vm` | planned |
| `windows-vm` | `building-blocks/compute/windows-vm` | planned |
| `key-vault` | `building-blocks/data/key-vault` | planned |
| `mysql-flexible-server` | `building-blocks/data/mysql-flexible-server` | planned |
| `storage-account` | `building-blocks/data/storage-account` | planned |
| `managed-identity` | `building-blocks/foundation/managed-identity` | planned |
| `management-lock` | `building-blocks/foundation/management-lock` | planned |
| `resource-group` | `building-blocks/foundation/resource-group` | implemented |
| `role-assignment` | `building-blocks/foundation/role-assignment` | planned |
| `application-insights` | `building-blocks/monitoring/application-insights` | planned |
| `diagnostic-settings` | `building-blocks/monitoring/diagnostic-settings` | planned |
| `log-analytics` | `building-blocks/monitoring/log-analytics` | planned |
| `application-gateway` | `building-blocks/networking/application-gateway` | planned |
| `bastion` | `building-blocks/networking/bastion` | planned |
| `load-balancer` | `building-blocks/networking/load-balancer` | planned |
| `network-security-group` | `building-blocks/networking/network-security-group` | planned |
| `private-dns-zone` | `building-blocks/networking/private-dns-zone` | planned |
| `private-endpoint` | `building-blocks/networking/private-endpoint` | planned |
| `public-ip` | `building-blocks/networking/public-ip` | planned |
| `route-table` | `building-blocks/networking/route-table` | planned |
| `subnet` | `building-blocks/networking/subnet` | planned |
| `virtual-network` | `building-blocks/networking/virtual-network` | planned |

### Patterns
| Name | Path | Status |
|---|---|---|
| `ai-hackathon` | `patterns/ai-hackathon` | implemented |
| `containerised-web-application` | `patterns/containerised-web-application` | planned |
| `drupal-website` | `patterns/drupal-website` | planned |
| `logic-app-integration` | `patterns/logic-app-integration` | planned |
| `serverless-api` | `patterns/serverless-api` | planned |
| `simple-website` | `patterns/simple-website` | planned |
| `web-development-environment` | `patterns/web-development-environment` | planned |

This table is generated by `python3 scripts/generate_catalogue.py`.
CI fails if you add or remove a module and leave this section stale.
<!-- END_CATALOGUE -->
