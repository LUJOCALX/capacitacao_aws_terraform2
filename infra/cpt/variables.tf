# Variaveis passadas pelo módulo network, necessárias para a criação das instancias do projeto
variable "sn_publicas" {}
variable "sn_privadas" {}
variable "sg_nginx" {}
variable "sg_apache" {}
variable "sn_pub_bastion_a" {}
variable "sg_bastion" {}

# Variável criada para a seleção dinâmica do arquivos que será utilizado no user_data
# das instâncias do NGINX
variable "arquivos_nginx" {
  default = {
    ljc_subnet_pub_a = "nginx_a_3200.sh",
    ljc_subnet_pub_b = "nginx_b_3300.sh",
    ljc_subnet_pub_c = "nginx_c_3400.sh"
  }
}

# Variável criada para a seleção dinâmica do arquivos que será utilizado no user_data
# das instâncias do APACHE
variable "arquivos_apache" {
  default = {
    ljc_subnet_prv_a = "apache_a_3001.sh",
    ljc_subnet_prv_b = "apache_b_3002.sh",
    ljc_subnet_prv_c = "apache_c_3003.sh"
  }
}

# Variável criada para a seleção via lista do private_ip
# das instâncias do NGINX
variable "ips_nginx" {
  default = {
    ljc_subnet_pub_a = "10.0.101.10",
    ljc_subnet_pub_b = "10.0.102.10",
    ljc_subnet_pub_c = "10.0.103.10"
  }
}

# Variável criada para a seleção via lista do private_ip
# das instâncias do APACHE
variable "ips_apache" {
  default = {
    ljc_subnet_prv_a = "10.0.1.10",
    ljc_subnet_prv_b = "10.0.2.10",
    ljc_subnet_prv_c = "10.0.3.10"
  }
}

