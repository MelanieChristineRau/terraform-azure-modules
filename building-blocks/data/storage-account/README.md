# Storage account

Status: planned

Official `stg` name with hyphens stripped. TLS 1.2. Public blobs off.

Portal equivalent: Create storage account, networking, encryption, containers

Use it when: Almost every pattern.

This folder is a scaffold. Do not run `terraform apply` here yet. When it is implemented it will:

1. Call `shared/naming` so the name matches the WCC standard
2. Call `shared/tags` so tags are not forgotten
3. Expose `id`, `name` and `resource_group_name`

Until then, if you need this resource as part of an environment, say so on the pattern that should own it. The AI hackathon pattern already creates some of these inline.

See [Choose your path](../../../docs/choose-your-path.md).
