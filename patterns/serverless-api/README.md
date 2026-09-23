# Simple website

Status: planned

Start here when you would say: "I need a website."

What you will get: Resource group, App Service plan, web app, Log Analytics, Application Insights.

Portal equivalent: Create plan, create web app, turn on Insights, remember HTTPS.

This pattern is not applyable yet. When it is, the steps will match the AI hackathon:

```bash
cd patterns/simple-website
cp terraform.tfvars.example terraform.tfvars
terraform init -backend-config=../../backends/sbx.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

It will compose building blocks. It will not become a second copy of raw Azure resources once those blocks exist.

See the working example: [AI Hackathon](../ai-hackathon/README.md).
