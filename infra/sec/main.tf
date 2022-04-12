# Security Group Criado para liberação de acesso as 3 instancias EC2 "NGINX" via portas: 
# 22   - ssh
# 3200 - Entrada nginx zona a
# 3300 - Entrada nginx zona b
# 3400 - Entrada nginx zona c
# 
# Recebe o valor da VPC pela variável "var.vpc_id" do módulo network para possibilitar
# a criação deste security group Está vinculado os security groups : [aws_security_group.portas_bastion.id]
# para permitir acessos da instancias do BASTION.

resource "aws_security_group" "portas_nginx" {
  name        = "allow_accesso_nginx_terraform"
  description = "Acesso ao Nginx criado pelo terraform VPC"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : [aws_security_group.portas_bastion.id]
      self : null
    },
    {
      description      = "Acesso nginx aza"
      from_port        = 3200
      to_port          = 3200
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Acesso nginx azb"
      from_port        = 3300
      to_port          = 3300
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Acesso nginx azc"
      from_port        = 3400
      to_port          = 3400
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    }
  ]
  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "sg-libera-acessos-nginx"
  }
}

# Security Group Criado para liberação de acesso as 3 instancias EC2 "APACHE" via portas: 
# 22   - ssh
# 3001 - Entrada apache zona a
# 3001 - Entrada apache zona b
# 3002 - Entrada apache zona c
# 
# Recebe o valor da VPC pela variável "var.vpc_id" do módulo network para possibilitar
# a criação deste security group. Está vinculado os security groups : [aws_security_group.portas_nginx.id, 
# aws_security_group.portas_bastion.id] para permitir somente acessos das instancias NGINX e BASTION.
resource "aws_security_group" "portas_apache" {
  name        = "allow_access_apache_terraform"
  description = "Acesso ao Apache criado pelo terraform VPC"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "libera ssh do bastion e nginx para o apache"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
      ipv6_cidr_blocks = []
      prefix_list_ids  = null,
      security_groups : [aws_security_group.portas_nginx.id, aws_security_group.portas_bastion.id]
      self : null
    },
    {
      description      = "libera nginx acessar portas 3001,3002,3003 apache"
      from_port        = 3001
      to_port          = 3003
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      security_groups  = [aws_security_group.portas_nginx.id, aws_security_group.portas_bastion.id] #Libera as instancias nginx a acessar o apache nas portas 3001 a 3003
      prefix_list_ids  = null,
      self : null
    }
  ]
  egress = [
    {
      description : "Libera dados da rede interna"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
    }
  ]

  tags = {
    Name = "sg-libera-acessos-apache"
  }
}


#Security Group via Dynamic Block  para liberação de acesso a instancia EC2 "BASTION" e APACHE "Teste"
#utiliza as variáveis "var.vpc_id" e "var.bastion_ingress" como fonte de valores para a criação deste security group
resource "aws_security_group" "portas_bastion" {
  vpc_id = var.vpc_id
  name   = "allow_access_bastion_terraform"
  tags = {
    Name = "sg-libera-acessos-bastion-meu-ip"
  }
  dynamic "ingress" {
    for_each = var.bastion_ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = ingress.value["protocol"]
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_security_group" "portas_bastion" {
#   name        = "allow_access_bastion_terraform"
#   description = "Acesso ao bastion criado pelo terraform VPC"
#   vpc_id      = var.vpc_id

#   ingress = [
#     {
#       description = "SSH servidor Bastion"
#       from_port   = 22
#       to_port     = 22
#       protocol    = "tcp"
#       cidr_blocks = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
#       #cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       prefix_list_ids  = null,
#       security_groups : null,
#       self : null
#     },
#     {
#       description      = "libera nginx acessar portas 3004 apache bastion"
#       from_port        = 3004
#       to_port          = 3004
#       protocol         = "tcp"
#       cidr_blocks      = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
#       ipv6_cidr_blocks = ["::/0"]
#       security_groups  = null,
#       prefix_list_ids  = null,
#       self : null
#     }
#   ]
#   egress = [
#     {
#       description : "Libera dados da rede interna"
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       prefix_list_ids  = null,
#       security_groups : null,
#       self : null,
#     }
#   ]

#   tags = {
#     Name = "sg-libera-acessos-bastion-meu-ip"
#   }
# }