# Web development environment

Status: planned

Start here when you would say: "I need somewhere to build a web application."

What you will get: Resource group, VNet, web app, storage, Key Vault, identity, optional MySQL.

Portal equivalent: A morning of networking plus app plus secrets.

This pattern is not applyable yet. When it is, the steps will match the AI hackathon:

```bash
cd patterns/web-development-environment
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=../../backends/sbx.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

It will compose building blocks. It will not become a second copy of raw Azure resources once those blocks exist.

See the working example: [AI Hackathon](../ai-hackathon/README.md).
