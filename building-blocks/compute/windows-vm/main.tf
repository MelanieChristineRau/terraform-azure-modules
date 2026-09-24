# --------------------------------------------------
# Naming and tags
# Official compute name: wcc<env><description><version>, max 15 characters.
# --------------------------------------------------

module "naming" {
  source = "../../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "vm"
  version_suffix = var.version_suffix
}

module "nsg_name" {
  source = "../../../shared/naming"

  company        = var.company
  environment    = var.environment
  description    = var.description
  resource_type  = "nsg"
  version_suffix = var.version_suffix
}

module "tags" {
  source = "../../../shared/tags"

  environment         = module.naming.environment
  owner               = var.owner
  cost_centre         = var.cost_centre
  application         = var.application
  data_classification = var.data_classification
  criticality         = var.criticality
  additional_tags     = var.tags
}

# --------------------------------------------------
# Network
# Private IP only. No public IP in this block.
# Tell Cyber Security if you later attach building-blocks/networking/public-ip.
# --------------------------------------------------

resource "azurerm_network_security_group" "this" {
  name                = module.nsg_name.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.tags.tags
}

# Inbound RDP is off unless allow_rdp_from_cidr is set. Bastion is the normal path.
resource "azurerm_network_security_rule" "rdp" {
  count = var.allow_rdp_from_cidr == "" ? 0 : 1

  name                        = "allow-rdp"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.allow_rdp_from_cidr
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
}

resource "azurerm_network_interface" "this" {
  name                = "${module.naming.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = module.tags.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic" # Azure picks an address from the subnet
    # No public_ip_address_id on purpose.
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

# --------------------------------------------------
# Virtual machine
# --------------------------------------------------

resource "azurerm_windows_virtual_machine" "this" {
  name                = module.naming.name
  computer_name       = module.naming.name # Windows computer name, same 15 character limit
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  timezone            = var.timezone
  network_interface_ids = [
    azurerm_network_interface.this.id
  ]
  tags = module.tags.tags

  os_disk {
    name                 = "${module.naming.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type = "SystemAssigned" # Azure creates an identity. No password stored for API calls.
  }

  patch_mode            = "AutomaticByPlatform"
  patch_assessment_mode = "AutomaticByPlatform"
  provision_vm_agent    = true
}