
provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.5.0"
  features {}

  subscription_id = "8a2cb147-c590-475b-992a-abcdcb3e89c4"
  client_id       = "abd047dd-ee7f-4a62-b930-1eea357ea045"
  client_secret   = "2Bxj.9Ek8BMj6ojqOx4mE-WUft7_rpU8y."
  tenant_id       = "7a339603-4648-4c91-b19b-2092e551c652"
}

resource "azurerm_resource_group" "rg"{
    name = "Terratest-rg"
    location = "Southeastasia"
}