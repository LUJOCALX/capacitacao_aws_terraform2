# Saida modulo Net
output "vpc" {
  value = module.network.vpc
}
# output "sn_publicas" {
#   value = "${module.network.sn_publicas}"
# }
# output "sn_privadas" {
#   value = "${module.network.sn_privadas}"
# }
output "sn_pub_a" {
  value = module.network.sn_pub_a
}
output "sn_pub_bastion_a" {
  value = module.network.sn_pub_bastion_a
}
output "sn_pub_b" {
  value = module.network.sn_pub_b
}
output "sn_pub_c" {
  value = module.network.sn_pub_c
}
output "sn_prv_a" {
  value = module.network.sn_prv_a
}
output "sn_prv_b" {
  value = module.network.sn_prv_b
}
output "sn_prv_c" {
  value = module.network.sn_prv_c
}

# Saida modulo Sec
output "sg_nginx" {
  value = module.security.sg_nginx
}
output "sg_apache" {
  value = module.security.sg_apache
}
output "sg_bastion" {
  value = module.security.sg_bastion
}


# Saida modulo cpt
output "links_ec2_NGINX" {
  value = module.compute.links_ec2_NGINX
}

output "links_ec2_APACHE" {
  value = module.compute.links_ec2_APACHE
}