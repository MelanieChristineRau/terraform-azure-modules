# Authentication

This repository is authentication-agnostic.

The provider configuration is:

```hcl
provider "azurerm" {
  features {}
}
```

Not stored in this repository:

- passwords
- client secrets
- subscription IDs
- tenant IDs
- service principal names
- login scripts

Engineers (or the pipeline) supply authentication at apply time. Typical options:

- Azure CLI (`az login`) on a workstation
- OpenID Connect federated credential in GitHub Actions
- Managed identity on an Azure-hosted runner
- Azure DevOps ARM service connection

`data.azurerm_client_config.current` is allowed. It reads the signed-in context at plan/apply time. It does not bake a tenant or subscription into git.
