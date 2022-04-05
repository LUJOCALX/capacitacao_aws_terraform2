resource "aws_instance" "ljc-ec2-nginx" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  for_each      = local.subnet_publica_ids
  subnet_id     = each.value # vincula a subnet direto e gera o IP automático
  vpc_security_group_ids = ["${var.sg_nginx}"]
  user_data              = file("./cpt/userdata/nginx_a_3200.sh")
  tags                   = merge(local.common_tags, { Name = "ec2-nginx-${each.key}" })
}

resource "aws_instance" "ljc-ec2-apache" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  for_each      = local.subnet_publica_ids
  subnet_id     = each.value # vincula a subnet direto e gera o IP automático
  vpc_security_group_ids = ["${var.sg_apache}"]
  user_data              = file("./cpt/userdata/apache_3001.sh")
  tags                   = merge(local.common_tags, { Name = "ec2-apache-${each.key}" })
}