module "m1" {
  source = "../../resources/resource.group"
  rgs = var.rgs
}

module "m2" {
  source = "../../resources/virtual.network"
  vnets = var.vnets
  depends_on = [ module.m1 ]
}

module "m3" {
  source = "../../resources/subnet"
  subnet = var.subnet
  depends_on = [ module.m2, module.m5 ]
}

module "m4" {
  source = "../../resources/public.ip"
  pips = var.pips
  depends_on = [ module.m1 ]
}

module "m5" {
  source = "../../resources/n.s.g"
  nsg = var.nsg
  depends_on = [ module.m1 ]
}

module "m6" {
  source = "../../resources/network.interfase"
  nic = var.nic
  depends_on = [ module.m3, module.m4 ]
}

module "m7" {
  source = "../../resources/vm"
  vms = var.vms
  depends_on = [ module.m6 ]
}

module "m8" {
  source       = "../../resources/app_gateway"
  app_gateways = var.app_gateways
  backend_nics = var.nic
  depends_on   = [ module.m3, module.m4, module.m6 ]
}