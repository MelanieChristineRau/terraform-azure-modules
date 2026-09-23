# Linux virtual machine

Status: planned

NIC, NSG attach, VM and optional data disk as one block. Name stays under 15 characters.

Portal equivalent: Create VM: disk, NIC, NSG, extensions

Use it when: A jump box or a small Linux workload. No passwords in examples.

This folder is a scaffold. Do not run `terraform apply` here yet. When it is implemented it will:

1. Call `shared/naming` so the name matches the WCC standard
2. Call `shared/tags` so tags are not forgotten
3. Expose `id`, `name` and `resource_group_name`

Until then, if you need this resource as part of an environment, say so on the pattern that should own it. The AI hackathon pattern already creates some of these inline.

See [Choose your path](../../../docs/choose-your-path.md).
