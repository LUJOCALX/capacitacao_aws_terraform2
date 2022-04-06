# Saida de informações do módulo sec

output "sg_nginx" {
  value = aws_security_group.portas_nginx.id
}
output "sg_apache" {
  value = aws_security_group.portas_apache.id
}

output "sg_bastion" {
  value = aws_security_group.portas_bastion.id
}
