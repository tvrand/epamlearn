resource "azurerm_service_plan" "appsvcplan" {
  name                = "epamlearnappsvcplan"
  location            = var.rglocation
  resource_group_name = var.rgname
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "myapp" {
  name                = "epamlearnappsvc"
  resource_group_name = var.rgname
  location            = var.rglocation
  service_plan_id     = azurerm_service_plan.appsvcplan.id
  identity {
    type         = "UserAssigned"
    identity_ids = [var.uid]
  }
  site_config {
    always_on = false
  }
}
