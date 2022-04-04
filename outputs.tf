output "Meu_IP" {
  value = ["${chomp(data.http.myip.body)}"]
}

output "subnets_publica" {
  value = { for k, v in aws_subnet.subnet_publica : v.tags.Name => v.id }
}

output "subnets_privada" {
  value = { for k, v in aws_subnet.subnet_privada : v.tags.Name => v.id }
}

# output "links_ec2_NGINX" {

#   value = [
#     "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}",
#     "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_a"].public_dns}:3200",
#     "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}",
#     "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_b"].public_dns}:3200",
#     "IP Publico: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}",
#     "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-nginx["ljc_subnet_pub_c"].public_dns}:3200"
#   ]

# }


# output "links_ec2_APACHE" {

#   value = [
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_dns}",
#     "APACHE_AZA_3001 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_a"].public_dns}:3001",
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_dns}",
#     "APACHE_AZB_3002 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_b"].public_dns}:3002",
#     "IP Publico: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_ip}",
#     "IP Privado: ${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].private_ip}",
#     "ssh ubuntu@${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_dns}",
#     "APACHE_AZC_3003 http://${aws_instance.ljc-ec2-apache["ljc_subnet_pub_c"].public_dns}:3003"
#   ]

# }

