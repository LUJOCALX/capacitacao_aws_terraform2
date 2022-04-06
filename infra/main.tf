provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./net"
}

module "security" {
  source = "./sec"
  vpc_id = module.network.vpc
}

module "compute" {
  source           = "./cpt"
  sn_publicas      = module.network.sn_publicas
  sn_privadas      = module.network.sn_privadas
  sn_pub_bastion_a = module.network.sn_pub_bastion_a
  sg_nginx         = module.security.sg_nginx
  sg_apache        = module.security.sg_apache
  sg_bastion       = module.security.sg_bastion
}