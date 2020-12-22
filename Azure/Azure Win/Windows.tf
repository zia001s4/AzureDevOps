provider "azurerm" {
  version = "=2.8.0"
  features {}
  subscription_id = "8a2cb147-c590-475b-992a-abcdcb3e89c4"
  client_id       = "abd047dd-ee7f-4a62-b930-1eea357ea045"
  client_secret   = "2Bxj.9Ek8BMj6ojqOx4mE-WUft7_rpU8y."
  tenant_id       = "7a339603-4648-4c91-b19b-2092e551c652"
}



#create the resource group
resource "azurerm_resource_group" "rg" {
    name = var.rg_name
    location = var.location
}



#create the virtual network
resource "azurerm_virtual_network" "vnet1" {
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    name = var.vnet_name
    address_space = [var.address_space]
}

#create a subnet within the virtual network
resource "azurerm_subnet" "subnet1" {
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    name = var.subnet_name
    address_prefixes = [var.snet_prefix]
}

#create the Public IP for the VM
resource "azurerm_public_ip" "pub_ip" {
    name = "vmpubip"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
}

/*

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = "myNetworkSecurityGroup"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "RDP"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Dev"
    }
}

#create the network interface for the VM
resource "azurerm_network_interface" "vmnic" {
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    name = "vmnic1"

    ip_configuration {
        name = "vmnic1-ipconf"
        subnet_id = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pub_ip.id
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.vmnic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

##create the Random Password for VM Login
resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

output "Password" {
  value = random_password.password.result
}

##create the actual VM
resource "azurerm_windows_virtual_machine" "devvm" {
    name = "development-vm"
    location = azurerm_resource_group.rg.location
    size = "Standard_A1_v2"
    admin_username = "adm_zsid"
    admin_password =random_password.password.result
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [azurerm_network_interface.vmnic.id]
    
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }


}


##end creating VM

*/