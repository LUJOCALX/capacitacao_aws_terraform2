# Criação de 3 instancias Nginx usando "for_each" recebendo informações também de ip, security groups,
# arquivos "user_data" e tags comuns de variaveis locais e de módulos

resource "aws_instance" "ljc-ec2-nginx" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  for_each               = local.subnet_publica_ids
  subnet_id              = each.value # vincula a subnet direto e gera o IP automático
  private_ip             = var.ips_nginx[each.key]
  vpc_security_group_ids = ["${var.sg_nginx}"]
  user_data              = file("./cpt/userdata/${var.arquivos_nginx[each.key]}")
  tags                   = merge(local.common_tags, { Name = "ec2-nginx-${each.key}" })
}

# Criação de 3 instancias Apache usando "for_each" recebendo informações também de ip, security groups,
# arquivos "user_data" e tags comuns de variaveis locais e de módulos

resource "aws_instance" "ljc-ec2-apache" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  for_each               = local.subnet_privada_ids
  subnet_id              = each.value
  private_ip             = var.ips_apache[each.key]
  vpc_security_group_ids = ["${var.sg_apache}"]
  user_data              = file("./cpt/userdata/${var.arquivos_apache[each.key]}")
  tags                   = merge(local.common_tags, { Name = "ec2-apache-${each.key}" })
}

# Criação da instância Bastion para possibilitar o acesso as instâncias "Apache" para facilitar
# a configuração e testes. Recebendo também informações de váriáveis (Ids de subnets, security group) passados 
# pelo ódulo network 

resource "aws_instance" "ljc_subnet_bastion_a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  subnet_id              = var.sn_pub_bastion_a
  private_ip             = "10.0.104.10"
  vpc_security_group_ids = ["${var.sg_bastion}"]
  user_data              = file("./cpt/userdata/bastion_a.sh")
  tags = merge(local.common_tags, {
    Name         = "Instancia Bastion Host",
    "Criado por" = "Terraform"
  })
}