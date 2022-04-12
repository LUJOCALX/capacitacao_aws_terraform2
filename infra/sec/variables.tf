# utiliza esta variável para a passagem do id da VPC, criada no módulo network, que é  
# necessária para a criação dos security groups.
variable "vpc_id" {}

#utiliza esta variável como fonte de valores para a criação do security group "portas_bastion"
#Libera o acesso as portas 22 (ssh) e 3004 (Bastion Teste)
variable "bastion_ingress" {
  type = map(object({ description = string, cidr_blocks = list(string), protocol = string }))
  default = {
    22   = { description = "Inbound para SSH", cidr_blocks = ["0.0.0.0/0"], protocol = "tcp" }
    3004 = { description = "Inbound para apache", cidr_blocks = ["0.0.0.0/0"], protocol = "tcp" }
  }
}
