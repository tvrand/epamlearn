resource "azurerm_lb" "lb" {
  name                = "LoadB15"
  location            = var.rglocation
  resource_group_name = var.rgname

  frontend_ip_configuration {
    name                 = "frontendipforlb"
    public_ip_address_id = var.frontip
  }
}

resource "azurerm_lb_rule" "lbrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "Lbruleterraform"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontendipforlob"
}

resource "azurerm_lb_backend_address_pool" "mypool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}
