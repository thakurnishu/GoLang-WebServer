resource "azurerm_kubernetes_cluster" "aks" {
  name = var.cluster_name
  location = var.location
  resource_group_name = var.rg_name
  dns_prefix = "${var.cluster_name}-goserver"

  default_node_pool {
    name = var.pool_name
    node_count = var.node_count
    vm_size = var.size_of_node
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "kubeconfig" {
  content = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = "kubeconfig"
  depends_on = [ azurerm_kubernetes_cluster.aks ]
}