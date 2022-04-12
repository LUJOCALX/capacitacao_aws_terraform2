# Exposição das informações (links de acesso ssh, ao Apache e de validações "curl") da instância do Bastion.
output "links_ec2_BASTION" {
  value = [
    "IP Publico: ${aws_instance.ljc_subnet_bastion_a.public_ip}",
    "IP Privado: ${aws_instance.ljc_subnet_bastion_a.private_ip}",
    "ssh ubuntu@${aws_instance.ljc_subnet_bastion_a.public_dns}",
    "APACHE_AZA_3004 http://${aws_instance.ljc_subnet_bastion_a.public_dns}:3004",
    "CURL_NGINX_AZB_3300 curl http://${aws_instance.ljc_subnet_bastion_a.public_dns}:3004 --head"    
  ]

}

# Exposição das informações (links de acesso ssh, ao Apache e de validações "curl") das instâncias NGINX.
output "links_ec2_NGINX" {
  value = [
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}",
    "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}:3200",
    "CURL_NGINX_AZA_3200 curl http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}:3200 --head",
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}",
    "NGINX_AZB_3300 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}:3300",
    "CURL_NGINX_AZB_3300 curl http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}:3300 --head",
    "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}",
    "NGINX_AZC_3400 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}:3400",
    "CURL_NGINX_AZc_3400 curl http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}:3400 --head"
  ]

}

# Exposição das informações (links de acesso ssh, ao Apache e de validações "curl") das instâncias APACHE.
output "links_ec2_APACHE" {

  value = [
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}",
    "APACHE_AZA_3001 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].public_dns}:3001",
    "CURL_APACHE_AZA_3001 curl ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_a"].private_ip}:3001 --head",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}",
    "APACHE_AZB_3002 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].public_dns}:3002",
    "CURL_APACHE_AZB_3002 curl ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_b"].private_ip}:3002 --head",
    "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_ip}",
    "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}",
    "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}",
    "APACHE_AZC_3003 http://${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].public_dns}:3003",
    "CURL_APACHE_AZC_3003 curl ${aws_instance.ljc-ec2-apache["ljc_subnet_prv_c"].private_ip}:3003 --head"
  ]

}

