variable "rg_name" {
    type = string
    description = "My Resource Group Name"
}

variable "location" {
    type = string
    description = "Default location for all the Resources"
}

variable "vnet_name" {
    type = string
    description = "Vnet Name for IAAS"
}

variable "address_space" {
    #type = string
    description = "Vnet Address Space"
}

variable "subnet_name" {
    type = string
    description = "Subnet name for the Vnet"
}

variable "snet_prefix" {
    #type = number
    description = "Address prefix for subnet"
}

variable "pip_name" {
    type = string
    description = " Public IP Name"
}



