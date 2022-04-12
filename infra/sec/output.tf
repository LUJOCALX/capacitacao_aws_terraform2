# Exposição do id dos security groups do módulo "Security"

# Exposição do id do security group do Nginx para poder ser utilizado pelos demais módulos.
output "sg_nginx" {
  value = aws_security_group.portas_nginx.id
}

# Exposição do id do security group do Apache para poder ser utilizado pelos demais módulos.
output "sg_apache" {
  value = aws_security_group.portas_apache.id
}

# Exposição do id do security group do Bastion para poder ser utilizado pelos demais módulos.
output "sg_bastion" {
  value = aws_security_group.portas_bastion.id
}
