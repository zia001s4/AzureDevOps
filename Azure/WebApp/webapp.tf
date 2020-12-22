# Create Two VMs with Availablity set.
provider "azurerm" {
  version = "=2.8.0"
  features {}
  #Hari Subscription
  subscription_id = "8a2cb147-c590-475b-992a-abcdcb3e89c4"
  client_id       = "abd047dd-ee7f-4a62-b930-1eea357ea045"
  client_secret   = "2Bxj.9Ek8BMj6ojqOx4mE-WUft7_rpU8y."
  tenant_id       = "7a339603-4648-4c91-b19b-2092e551c652"
}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "zedappservice"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}