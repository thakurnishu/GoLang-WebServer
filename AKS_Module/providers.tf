provider "azurerm" {
  subscription_id = var.AZURE_SUBSCRIPTION_ID
  client_id       = var.SERVICE_PRINCIPAL_ID
  client_secret   = var.SERVICE_PRINCIPAL_PASSWORD
  tenant_id       = var.AZURE_TENANT_ID
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}
