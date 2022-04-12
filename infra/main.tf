# Bloco principal responsável pela chamada dos demais módulos (network, security e compute), 
# para o provisionamento da infraestrutura.
#

provider "aws" {
  region = "us-east-1"
}

# O source do módulo network está na pasta ./net, e é responsável pela criação de toda infraestrutura
# de rede do projeto. Cria uma VPC, 4 subnets publicas, 3 subnets privadas, um internet gateway,
# um nat gateway, uma route table privada vinculada ao nat gateway e associada as subnets privadas,
# e uma route table publica vinculada ao internet gateway e associada as subnets publicas.

module "network" {
  source = "./net"
}

# O source do módulo security está na pasta ./sec, e é responsável pela criação dos security groups (portas_nginx,
# portas_apache, portas_bastion), necessários para o controle do tráfego e acesso de rede entre/aos servidores do projeto)
# Ele recebe o Id da VPC criada pela variavel vpc_id.

module "security" {
  source = "./sec"
  vpc_id = module.network.vpc
}


# O source do módulo compute está na pasta ./cpt, e é responsável pela criação de todas as instancias do projeto)
# Ele recebe variaveis de subnets publicas e privadas do módulo network e dos security groups do módulo security
# que são necessárias para a criação destas instancias.
module "compute" {
  source           = "./cpt"
  sn_publicas      = module.network.sn_publicas
  sn_privadas      = module.network.sn_privadas
  sn_pub_bastion_a = module.network.sn_pub_bastion_a
  sg_nginx         = module.security.sg_nginx
  sg_apache        = module.security.sg_apache
  sg_bastion       = module.security.sg_bastion
}