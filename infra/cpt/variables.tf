variable "sn_publicas" {}
variable "sn_privadas" {}
variable "sg_nginx" {}
variable "sg_apache" {}

variable "arquivos_nginx" {
default = {
    ljc_subnet_pub_a = "nginx_a_3200.sh",
    ljc_subnet_pub_b = "nginx_b_3300.sh",
    ljc_subnet_pub_c = "nginx_c_3400.sh"
}
}

variable "arquivos_apache" {
default = {
    ljc_subnet_pub_a = "apache_a_3001.sh",
    ljc_subnet_pub_b = "apache_b_3002.sh",
    ljc_subnet_pub_c = "apache_c_3003.sh"
}
}
