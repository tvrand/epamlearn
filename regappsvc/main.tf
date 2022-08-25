provider "azurerm" {
  features {}
}

module "resource_group" {
  source     = "./modules/resourcegroup/"
  rglocation = var.location
  rgname     = var.name
}

module "acr" {
  source     = "./modules/acr/"
  rglocation = module.resource_group.location
  rgname     = module.resource_group.name

}

module "managedidentity" {
  source     = "./modules/managedidentity/"
  rglocation = module.resource_group.location
  rgname     = module.resource_group.name
  acrscope   = module.acr.scope
}

module "appsvc" {
  source     = "./modules/appservice/"
  rglocation = module.resource_group.location
  rgname     = module.resource_group.name
  uid        = module.managedidentity.identityid
}
