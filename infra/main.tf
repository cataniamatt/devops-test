resource "azurerm_resource_group" "rg_test" {
  name = "rg-matthew-catania-${var.env}-${var.loc}"
  location = var.location
}

