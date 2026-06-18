resource "azurerm_user_assigned_identity" "app" {
  name                = "id-${local.base}-app"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = local.tags

  lifecycle {
    ignore_changes = [tags["created_date"]]
  }
}

resource "azurerm_role_assignment" "app_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.app.principal_id
}

resource "azurerm_container_app" "main" {
  name                         = "ca-${local.base}-notes"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"
  tags                         = local.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app.id]
  }

  registry {
    server   = azurerm_container_registry.main.login_server
    identity = azurerm_user_assigned_identity.app.id
  }

  ingress {
    external_enabled = true
    target_port      = 8000
    transport        = "http"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    min_replicas = 0
    max_replicas = 3

    container {
      name   = "notes-api"
      image  = "${azurerm_container_registry.main.login_server}/notes-api:bootstrap"
      cpu    = 0.25
      memory = "0.5Gi"
    }

    http_scale_rule {
      name                = "http-rule"
      concurrent_requests = "20"
    }
  }

  lifecycle {
    ignore_changes = [
      tags["created_date"],
      template[0].container[0].image, # CI/CD updates the image
    ]
  }

  depends_on = [azurerm_role_assignment.app_acr_pull]
}
