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