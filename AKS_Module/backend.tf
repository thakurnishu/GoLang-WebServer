terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-State-RG"
    storage_account_name = "terraformstate54321"
    container_name       = "gowebserver"
    key                  = "terraform.tf"
    # access_key = var.STORAGE_KEY
  }
}