variable "subnet" {}

data "azurerm_network_security_group" "nsg" {
  for_each            = var.subnet
  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = var.subnet
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg[each.key].id
}
