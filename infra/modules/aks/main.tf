resource "azurerm_kubernetes_cluster" "aks" {
  name = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = var.dns_prefix
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.default_node_pool_vm_size
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "registry_permissions" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}