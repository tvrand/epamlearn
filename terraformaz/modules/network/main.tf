resource "azurerm_network_security_group" "lbsecgroup" {
  name                = "vnetsecgroup"
  location            = var.rglocation
  resource_group_name = var.rgname
}

resource "azurerm_network_security_rule" "mysecrule" {
  name                        = "RuleviaTerraform"
  resource_group_name         = var.rgname
  network_security_group_name = azurerm_network_security_group.lbsecgroup.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_virtual_network" "lbvnet" {
  name                = "loadbalancervnet"
  location            = var.rglocation
  resource_group_name = var.rgname
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "backsubnet" {
  name                 = "backend_subnet"
  address_prefixes     = ["10.0.0.0/24"]
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.lbvnet.name
}

resource "azurerm_subnet" "bastionsubnet" {
  name                 = "AzureBastionSubnet"
  address_prefixes     = ["10.0.1.0/27"]
  resource_group_name  = var.rgname
  virtual_network_name = azurerm_virtual_network.lbvnet.name
}

resource "azurerm_public_ip" "lbpubip" {
  count               = 2
  name                = "Public IP ${count.index}"
  location            = var.rglocation
  resource_group_name = var.rgname
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "lbbastion" {
  name                = "BastionforVM"
  location            = var.rglocation
  resource_group_name = var.rgname

  ip_configuration {
    name                 = "ipconfigforbastion"
    subnet_id            = azurerm_subnet.bastionsubnet.id
    public_ip_address_id = azurerm_public_ip.lbpubip[0].id
  }
}


resource "azurerm_network_interface" "mynics" {
  count               = 2
  name                = "nic-${count.index}"
  location            = var.rglocation
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.backsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
