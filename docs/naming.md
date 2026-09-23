# Naming

Source: official WCC Azure naming standard.

## Rules

- Lowercase for resource groups and resource names
- Hyphens where Azure allows them
- Version is optional
- With hyphens: `wcc-<env>-<description>-<resourcetype><version>`
- Without hyphens: `wcc<env><description><resourcetype><version>`
- Virtual machines stay under 15 characters
- Storage Account and Data Lake names cannot contain hyphens, so the module strips them

## Official abbreviations used in v1

rg, vnet, subnet, pl, pe, pip, nsg, alb, agw, stg, dls, plan, app, func, cr, appi, log, srch, kv

Virtual machines have no abbreviation.

## Proposed abbreviations (not yet in the official table)

id, lock, bas, udr, logic, ca, cae, mysql, diag, aif, oai, di

Propose these on the naming standard page when the matching building block is onboarded.
