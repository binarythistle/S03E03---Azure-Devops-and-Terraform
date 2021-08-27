terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Australia East"

  tags={
    environment ="terraform demo"
  }
}

resource "azurerm_virtual_network" "myterraformnetwork"{
  name ="terraformVnet"
  address_space =["10.0.0.0/16"]
  location = "Australia East"
  resource_group_name = azurerm_resource_group.tf_test.name

  tags={
    environment ="terraform demo"
  }
}

resource "azurerm_subnet" "myterraformsubnet"{
  name ="terraformSubnet"
  resource_group_name = azurerm_resource_group.tf_test.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefix  = "10.0.1.0/24"
}