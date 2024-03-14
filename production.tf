locals {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "networking" {
  source = "./modules/networking"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  web_subnets_cidr   = var.web_subnets_cidr
  app_subnets_cidr   = var.app_subnets_cidr
  db_subnets_cidr    = var.db_subnets_cidr
  availability_zones = local.availability_zones
}
