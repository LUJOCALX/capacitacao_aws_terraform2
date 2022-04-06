variable "sn_publicas" {}
variable "sn_privadas" {}
variable "sg_nginx" {}
variable "sg_apache" {}
variable "sn_pub_bastion_a" {}
variable "sg_bastion" {}

variable "arquivos_nginx" {
  default = {
    ljc_subnet_pub_a = "nginx_a_3200.sh",
    ljc_subnet_pub_b = "nginx_b_3300.sh",
    ljc_subnet_pub_c = "nginx_c_3400.sh"
    #ljc_subnet_bastion_a = "bastion_a.sh"
  }
}

variable "arquivos_apache" {
  default = {
    ljc_subnet_prv_a = "apache_a_3001.sh",
    ljc_subnet_prv_b = "apache_b_3002.sh",
    ljc_subnet_prv_c = "apache_c_3003.sh"
    #ljc_subnet_bastion_a = "bastion_a.sh"
  }
}
