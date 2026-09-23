# Contributing to WCC Azure building blocks

## How this repository is organised

- `shared/` holds naming and tags used by every block
- `building-blocks/` holds reusable WCC building blocks
- `patterns/` holds known WCC environments that compose blocks
- Engineers should not need to think in Terraform module catalogues first

## Rules

1. One repository. Do not split compute, app or website into separate GitHub repos for v1.
2. Authentication stays agnostic. The `azurerm` provider block must not contain credentials, subscription IDs, tenant IDs or service principals.
3. Names come from `shared/naming`. Do not hardcode `wcc-sbx-...` strings in a block.
4. Do not add a general budget building block. Budgets belong only in the AI Hackathon pattern.
5. Keep variables small. Optional features are opt in.
6. If a resource abbreviation is missing from the official WCC naming table, propose it in the PR and add it to `docs/naming.md`.
7. Follow `docs/practices.md`: small blast radius, pinned versions, remote state per environment, plan before apply, never commit or hand-edit state.

## README shape

Every folder people open needs the same story:

1. What this is, in one sentence
2. Portal work it replaces
3. Whether it is ready
4. Copy-paste commands
5. What to edit in `terraform.tfvars`
6. What names and resources you get
7. How to destroy it

Look at `patterns/ai-hackathon/README.md` and `building-blocks/foundation/resource-group/README.md`.

## Adding a building block

1. Implement `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf` and `README.md`
2. Add `examples/basic` with `terraform.tfvars.example`
3. Wire CI if the block is ready to validate
4. Link it from `docs/choose-your-path.md`

## Adding a pattern

A pattern composes building blocks. It represents an environment, not a single Azure resource.

## Style

Run `terraform fmt`. There is no other formatter config.

Comments use `#` only. Section headers look like:

```hcl
# --------------------------------------------------
# Resource group
# --------------------------------------------------
```

See `docs/tooling.md` for fmt, validate hooks and GitHub Actions.

## Docs and lint

Every implemented module README must contain:

```markdown
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

`terraform-docs` injects inputs, outputs and resources between those markers when files change.

The root README catalogue is generated from the tree by `scripts/generate_catalogue.py`. Add or remove a folder and run `make docs`.

```bash
pre-commit install
make docs
```

CI fails if those generated sections are stale.
