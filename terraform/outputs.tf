output "app_fqdn" {
  value = azurerm_container_app.main.latest_revision_fqdn
}

output "acr_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "acr_name" {
  value = azurerm_container_registry.main.name
}

output "resource_group" {
  value = azurerm_resource_group.main.name
}

output "container_app_name" {
  value = azurerm_container_app.main.name
}
