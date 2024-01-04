variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "AZURE_SUBSCRIPTION_ID" {
  type = string
}
variable "AZURE_TENANT_ID" {
  type = string
}
variable "SERVICE_PRINCIPAL_ID" {
  type = string
}
variable "SERVICE_PRINCIPAL_PASSWORD" {
  type = string
}
# variable "cluster_name" {
#   type        = string
#   description = "AKS name in Azure"
# }
# variable "kubernetes_version" {
#   type        = string
#   description = "Kubernetes version"
# }
# variable "system_node_count" {
#   type        = number
#   description = "Number of AKS worker nodes"
# }
# variable "acr_name" {
#   type        = string
#   description = "ACR name"
# }