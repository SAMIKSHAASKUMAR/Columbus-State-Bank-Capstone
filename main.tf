terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# The container for all your stuff
resource "azurerm_resource_group" "rg" {
  name     = "rg-austin-pipeline-dev"
  location = "East US" 
}

# The 'Data Lake' where raw files go
resource "azurerm_storage_account" "storage" {
  name                     = "austindata${random_id.id.hex}" # Must be unique!
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_id" "id" {
  byte_length = 4
}