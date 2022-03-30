# output "aws_instance_e_ssh" {
#   value = [
#     aws_instance.ljc-ec2-az-a.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-a.public_dns}",
#     "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-az-a.public_dns}:3200",
#     aws_instance.ljc-ec2-az-b.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-b.public_dns}",
#     "NGINX_AZB_3300 http://${aws_instance.ljc-ec2-az-b.public_dns}:3300",
#     aws_instance.ljc-ec2-az-c.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-c.public_dns}",
#     "NGINX_AZC_3400 http://${aws_instance.ljc-ec2-az-c.public_dns}:3400"
#   ]
# }


output "Meu_IP" {
  value = ["${chomp(data.http.myip.body)}"]
}

output "subnets_publica" {
  value = { for k, v in aws_subnet.subnet_publica : v.tags.Name => v.id }
}

output "subnets_privada" {
  value = { for k, v in aws_subnet.subnet_privada : v.tags.Name => v.id }
}

output "links_ec2_NGINX" {

  value = [
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}",
    "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}:3200",
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}",
    "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}:3200",
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}",
    "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}:3200"
  ]

}

# output "links_ec2_APACHE" {

#   value = [
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_dns}",
#     "APACHE_AZA_3001 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_dns}:3001",
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_dns}",
#     "APACHE_AZB_3002 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_dns}:3002",
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_dns}",
#     "APACHE_AZC_3003 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_dns}:3003"
#   ]

# }


output "links_ec2_APACHE" {

  value = [
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_dns}",
    "APACHE_AZA_3001 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_dns}:3001",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_dns}",
    "APACHE_AZB_3002 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_dns}:3002",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_dns}",
    "APACHE_AZC_3003 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_dns}:3003"
  ]

}


# module "vpc" {
#   source            = "terraform-aws-modules/vpc/aws" # inclusive pode colocar url do git aqui

#   name              = "meu_vpc_nat_gatway"
#   cidr              = "10.0.0.0/16" # uma classe de IP

#   azs               = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   private_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = true
#     Environment = "Dev"
#   }
# }