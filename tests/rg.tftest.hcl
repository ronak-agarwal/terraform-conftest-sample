variables {
  resource_group_name = "rgdemo"
  location = "centralus"
}

provider "azurerm" {
  features {}
}

run "unit_test_rg" {
  command = plan

  assert {
    condition     = azurerm_resource_group.rg.name == "rgdemo"
    error_message = "Resource Group name should be, rgdemo"
  }
}