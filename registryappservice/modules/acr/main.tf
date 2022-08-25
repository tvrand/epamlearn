resource "azurerm_container_registry" "myacr" {
  name                = "epamlearnregistry"
  resource_group_name = var.rgname
  location            = var.rglocation
  sku                 = "Standard"
}
