# Public IP

Status: planned

A Standard public IP address. Official name example: `wcc-sbx-hack-pip`.

This is an exception, not a default. Most WCC workloads should stay private (Private Endpoint, VNet integration, App Gateway / Front Door in front). A public IP on a NIC, VM or storage account is not the normal path.

## Security rule

Treat every public IP as **temporary** unless Cyber Security has signed off a longer life.

Before you apply this block:

1. Tell the Cyber Security team the subscription, resource group, what the IP will sit on, and how long it will exist
2. Put an expiry in the pattern README or ticket
3. Destroy the IP when the event or test ends. Do not leave it attached "just in case"

Sandbox does not remove this duty. A public IP in `sbx` is still on the internet.
