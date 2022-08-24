resource "azurerm_resource_group" "lbgroup" {
  name     = var.rgname
  location = var.location
}
