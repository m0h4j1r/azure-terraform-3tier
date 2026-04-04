output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "frontend_subnet_id" {
  description = "The ID of the Frontend subnet"
  value       = azurerm_subnet.frontend.id
}

output "app_subnet_id" {
  description = "The ID of the App subnet"
  value       = azurerm_subnet.app.id
}

output "data_subnet_id" {
  description = "The ID of the Data subnet"
  value       = azurerm_subnet.data.id
}
