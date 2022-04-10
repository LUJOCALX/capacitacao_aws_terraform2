resource "aws_security_group" "portas_nginx" {
  name        = "allow_accesso_nginx_terraform"
  description = "Acesso ao Nginx criado pelo terraform VPC"
  vpc_id      = var.vpc_id
  # ingress = [  # inbound - de fora (internet) para dentro da maquina
  ingress = [
    {
      description = "SSH from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
      #cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : [aws_security_group.portas_bastion.id]
      self : null
    },
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
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
  # egress = [ # outbound - de dentro nda maquina, para fora (internet)
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


resource "aws_security_group" "portas_apache" {
  name        = "allow_access_apache_terraform"
  description = "Acesso ao Apache criado pelo terraform VPC"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description = "libera ssh do bastion e nginx para o apache"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
      #cidr_blocks      = ["0.0.0.0/0"]
      #cidr_blocks      = []
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
    },
    {
      description      = "libera nginx acessar portas 80 apache"
      from_port        = 80
      to_port          = 80
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




resource "aws_security_group" "portas_bastion" {
  name        = "allow_access_bastion_terraform"
  description = "Acesso ao bastion criado pelo terraform VPC"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description = "SSH from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
      #cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
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
    Name = "sg-libera-acessos-bastion-meu-ip"
  }
}