# Environments

Official Azure designations from the WCC naming standard:

| Code | Meaning |
|---|---|
| prd | Production |
| pre | Preproduction |
| qas | Quality Assurance Staging |
| dev | Development |
| sbx | Sandbox |

`shared/naming` also accepts aliases and always emits the official code:

| Alias | Emits |
|---|---|
| prod, production | prd |
| preprod, pre-production | pre |
| qa | qas |
| development, intdev, preview | dev |
| sandbox | sbx |
| staging | dev |

Backend/frontend application codes (`prod`, `preprod`, `dev`, `qa`) map onto the same Azure designations.
