variable "app_gateways" {}
variable "backend_nics" {}

data "azurerm_subnet" "subnet" {
  for_each             = var.app_gateways
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
  for_each            = var.app_gateways
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gateways
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 100
  }
}

data "azurerm_network_interface" "nic" {
  for_each            = var.backend_nics
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "backend_assoc" {
  for_each                = var.backend_nics
  network_interface_id    = data.azurerm_network_interface.nic[each.key].id
  ip_configuration_name   = each.value.name_ip_conf
  backend_address_pool_id = tolist(azurerm_application_gateway.appgw["appgw1"].backend_address_pool)[0].id
}
