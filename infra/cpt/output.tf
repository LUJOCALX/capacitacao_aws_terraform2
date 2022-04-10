
output "links_ec2_BASTION" {
  value = [
    "IP Publico: ${aws_instance.ljc_subnet_bastion_a.public_ip}",
    "IP Privado: ${aws_instance.ljc_subnet_bastion_a.private_ip}",
    "ssh ubuntu@${aws_instance.ljc_subnet_bastion_a.public_dns}",
    "APACHE_AZA_3004 http://${aws_instance.ljc_subnet_bastion_a.public_dns}:3004"
  ]

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
    "NGINX_AZB_3300 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}:3300",
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}",
    "NGINX_AZC_3400 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}:3400"
  ]

}

output "links_ec2_APACHE" {

  value = [
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}",
    "APACHE_AZA_3001 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_dns}:3001",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}",
    "APACHE_AZB_3002 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_dns}:3002",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}",
    "APACHE_AZC_3003 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_dns}:3003"
  ]

}

