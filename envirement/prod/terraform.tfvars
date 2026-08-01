rgs = {
    rg1 = {
        name = "rg-prod-hit"
        location = "south india"
    }
}

vnets = {
    vnet1 = {
        name = "vnet-prod-hit"
        location = "south india"
        resource_group_name = "rg-prod-hit"
        address_space = ["10.0.0.0/16"]
    }
}

subnet = {
    subnet1 = {
        name = "subnet-prod-hit"
        virtual_network_name = "vnet-prod-hit"
        resource_group_name = "rg-prod-hit"
        address_prefixes = ["10.0.1.0/24"]
        nsg_name = "prod-hity-nsg"
    }
    subnet2 = {
        name = "subnet2-prod-hit"
        virtual_network_name = "vnet-prod-hit"
        resource_group_name = "rg-prod-hit"
        address_prefixes = ["10.0.2.0/24"]
        nsg_name = "prod-hity-nsg"
    }
    subnet3 = {
        name = "subnet-appgw"
        virtual_network_name = "vnet-prod-hit"
        resource_group_name = "rg-prod-hit"
        address_prefixes = ["10.0.3.0/24"]
        nsg_name = "prod-hity-nsg"
    }
}

pips = {
    pip1 = {
        name = "prod-pip-appgw"
        location = "south india"
        resource_group_name = "rg-prod-hit"
        allocation_method   = "Static"
        sku                 = "Standard"
    }
}

nic = {
    nic1 = {
        name  = "nicprodhit"
        location  = "south india"
        resource_group_name = "rg-prod-hit"
        virtual_network_name = "vnet-prod-hit"
        subnet_name = "subnet-prod-hit"
        name_ip_conf = "firstprodconf"
        private_ip = "Dynamic"
    }
    nic2 = {
        name  = "nicprodhit2"
        location  = "south india"
        resource_group_name = "rg-prod-hit"
        virtual_network_name = "vnet-prod-hit"
        subnet_name = "subnet2-prod-hit"
        name_ip_conf = "secondprodconf"
        private_ip = "Dynamic"
    }
    # nic3 = {
    #     name  = "nicprodhit3"
    #     location  = "south india"
    #     resource_group_name = "rg-prod-hit"
    #     virtual_network_name = "vnet-prod-hit"
    #     subnet_name = "subnet2-prod-hit"
    #     name_ip_conf = "thirdprodconf"
    #     private_ip = "Dynamic"
    # }
    # nic4 = {
    #     name  = "nicprodhit4"
    #     location  = "south india"
    #     resource_group_name = "rg-prod-hit"
    #     virtual_network_name = "vnet-prod-hit"
    #     subnet_name = "subnet-prod-hit"
    #     name_ip_conf = "fourthprodconf"
    #     private_ip = "Dynamic"
    # }
}

vms = {
vm1 = {
    name                = "prodhitymachine"
  resource_group_name = "rg-prod-hit"
  location            = "south india"
  size                = "Standard_D4_v5"
  admin_username      = "adminuser"
  admin_password = "hitesh@12345"
  nic = "nicprodhit"
}
vm2 = {
  name                = "prodhitymachine2"
  resource_group_name = "rg-prod-hit"
  location            = "south india"
  size                = "Standard_D4_v5"
  admin_username      = "adminuser"
  admin_password = "hitesh@12345"
  nic = "nicprodhit2"
}
# vm3 = {
#   name                = "prodhitymachine3"
#   resource_group_name = "rg-prod-hit"
#   location            = "south india"
#   size                = "Standard_D4_v5"
#   admin_username      = "adminuser"
#   admin_password = "hitesh@12345"
#   nic = "nicprodhit3"
# }
# vm4 = {
#   name                = "prodhitymachine4"
#   resource_group_name = "rg-prod-hit"
#   location            = "south india"
#   size                = "Standard_D4_v5"
#   admin_username      = "adminuser"
#   admin_password = "hitesh@12345"
#   nic = "nicprodhit4"
# }
}

nsg = {
    nsg1 = {
         name                = "prod-hity-nsg"
  resource_group_name = "rg-prod-hit"
  location            = "south india"
    }
}

app_gateways = {
    appgw1 = {
        name                 = "prod-appgw"
        location             = "south india"
        resource_group_name  = "rg-prod-hit"
        virtual_network_name = "vnet-prod-hit"
        subnet_name          = "subnet-appgw"
        public_ip_name       = "prod-pip-appgw"
    }
}