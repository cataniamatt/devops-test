resource "azurerm_resource_group" "rg" {
  name     = "rg-mcatania-${var.env}-${var.loc}"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "acrmcatania${var.env}${var.loc}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
}

module "aks" {
  source              = "./modules/aks"
  name                = "aks-mcatania-${var.env}-${var.loc}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = "mcatania"
  acr_id              = azurerm_container_registry.acr.id
}