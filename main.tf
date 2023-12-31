terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.35"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    organization  = "abc"
    business_unit = "core"
    itservice     = "xyz"
    environment   = "staging"
  }
}

resource "azurerm_storage_account" "storage" {
  name                      = "sademotestopa1"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = false #true

  tags = {
    organization  = "abc"
    business_unit = "core"
    itservice     = "xyz"
    environment   = "staging"
  }
}