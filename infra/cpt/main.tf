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

# resource "aws_instance" "ljc-ec2-apache" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t3.micro"
#   key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
#   for_each               = local.subnet_privada_ids
#   subnet_id              = each.value # vincula a subnet direto e gera o IP automático
#   vpc_security_group_ids = ["${var.sg_apache}"]
#   user_data              = file("./cpt/userdata/${var.arquivos_apache[each.key]}")
#   tags                   = merge(local.common_tags, { Name = "ec2-apache-${each.key}" })
# }

resource "aws_instance" "ljc_subnet_bastion_a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  subnet_id              = var.sn_pub_bastion_a
  private_ip             = "10.0.104.10"
  vpc_security_group_ids = ["${var.sg_bastion}"]
  user_data              = file("./cpt/userdata/bastion_a.sh")

  # # Copies the myapp.conf file to /etc/myapp.conf
  # provisioner "file" {
  #   source      = "~/.ssh/id_rsa"
  #   destination = "~/.ssh"
  # }

  tags = merge(local.common_tags, {
    Name         = "Instancia Bastion Host",
    "Criado por" = "Terraform"
  })
}