provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "./modules/resource_group/"
  rgname   = var.rgname
  location = var.location
}

module "network" {
  source     = "./modules/network/"
  rgname     = var.rgname
  rglocation = var.location
}

module "loadbalancer" {
  source     = "./modules/loadbalancer/"
  rgname     = var.rgname
  rglocation = var.location
  frontip    = module.network.ipforlb
}

module "vms" {
  source     = "./modules/virtualmachines"
  rgname     = var.rgname
  rglocation = var.location
  nicid1     = module.network.nic1
  nicid2     = module.network.nic2
}
