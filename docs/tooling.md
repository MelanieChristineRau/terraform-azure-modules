# Tooling

If you only want one-sentence definitions, start with [glossary.md](glossary.md).

## terraform fmt

`terraform fmt` is the only style rule. It is opinionated and has no config.

- Local and pre-commit: `terraform fmt` rewrites files
- CI: `terraform fmt -check -recursive` exits 0 only when every file already matches

Do not bikeshed alignment in review. Run fmt.

Comments use `#` only. Do not use `//` or block comments.

```hcl
# --------------------------------------------------
# Resource group
# --------------------------------------------------

resource "azurerm_resource_group" "this" {
  name = module.naming.name
}
```

Section headers use `# --------------------------------------------------`.

## pre-commit

```bash
pre-commit install
pre-commit run --all-files
```

Hooks:

| Hook | What it does |
|---|---|
| terraform_fmt | Canonical layout |
| terraform_tflint | Lint each module with the repo-root `.tflint.hcl`. `--init=true` installs the AzureRM plugin on first run. |
| terraform_docs | Inject inputs/outputs into each README |
| terraform_validate | `terraform init -backend=false` then `validate`, one directory at a time |
| catalogue-readme | Rebuild the root README catalogue |

`terraform_validate` uses `--retry-once-with-cleanup=true` so a broken `.terraform` directory is deleted and init is retried once. That path needs `jq`. It also sets parallelism to 1 so a shared `TF_PLUGIN_CACHE_DIR` cannot race.

Do not delete every `.terraform` directory yourself if you use Terraform workspaces.

## GitHub Actions

| Workflow | Job |
|---|---|
| `.github/workflows/ci.yml` | fmt -check, validate implemented modules, tflint, terraform-docs, catalogue drift |
| `.github/workflows/pre-commit.yml` | Same hooks as local pre-commit, on changed files |

The pre-commit workflow uses `ghcr.io/antonbabenko/pre-commit-terraform:v1.96.3`. Do not float on `latest`.

## Module versions and release

@todo Decide and document:

1. How building blocks are versioned (git tags such as `building-blocks/foundation/resource-group/v1.0.0` vs a single repo semver)
2. Whether patterns pin building-block source to a tag or to a relative path (v1 uses relative paths)
3. A `release.yml` workflow that publishes a changelog and tag
4. Whether `.terraform.lock.hcl` is committed for patterns only

Until that exists, treat `main` as the only consume path and keep module `source` relative.

Operating rules for state, plan/apply and blast radius are in `docs/practices.md`.
