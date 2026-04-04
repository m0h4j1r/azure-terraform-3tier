locals {
  common_tags = {
    Environment = var.environment
    Project     = "azure-3tier"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = local.common_tags
}

module "networking" {
  source    = "../../modules/networking"
  rg_name   = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
  vnet_name = "vnet-${var.environment}"
  tags      = local.common_tags
}

module "compute" {
  source         = "../../modules/compute"
  rg_name        = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
  app_subnet_id  = module.networking.app_subnet_id
  ssh_public_key = var.ssh_public_key
  instance_count = var.instance_count
  vm_sku         = var.vm_sku
  tags           = local.common_tags
}
