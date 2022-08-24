output "ipforlb" {
  value = azurerm_public_ip.lbpubip[1].id
}

output "nic1" {
  value = azurerm_network_interface.mynics[0].id
}

output "nic2" {
  value = azurerm_network_interface.mynics[1].id
}
