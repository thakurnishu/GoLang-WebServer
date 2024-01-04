
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source       = "./modules/aks"
  cluster_name = var.cluster_name
  location     = azurerm_resource_group.rg.location
  rg_name      = azurerm_resource_group.rg.name
  pool_name    = var.pool_name
  node_count   = var.node_count
  size_of_node = var.node_size
}