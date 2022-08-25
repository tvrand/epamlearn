resource "azurerm_user_assigned_identity" "uai" {
  resource_group_name = var.rgname
  location            = var.rglocation
  name                = "registry-uai"
}

data "azurerm_subscription" "primary" {}

resource "azurerm_role_assignment" "myrole" {
  scope                = var.acrscope
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
}
