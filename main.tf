provider "aws" {
  region = "us-east-1"
}

# resource "aws_instance" "ljc-ec2-az-a" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t3.micro"
#   key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
#   subnet_id              = aws_subnet.ljc_subnet_a.id         # vincula a subnet direto e gera o IP automático
#   private_ip             = "172.16.10.100"
#   vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
#   user_data              = file("./userdata/nginx_a_3200.sh")

#   tags = {
#     Name         = "Instancia AZ a"
#     "Criado por" = "Terraform"
#   }
# }

# resource "aws_instance" "ljc-ec2-az-b" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t3.micro"
#   key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
#   subnet_id              = aws_subnet.ljc_subnet_b.id         # vincula a subnet direto e gera o IP automático
#   private_ip             = "172.16.20.100"
#   vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
#   user_data              = file("./userdata/nginx_b_3300.sh")

#   tags = {
#     Name         = "Instancia AZ b"
#     "Criado por" = "Terraform"
#   }
# }

# resource "aws_instance" "ljc-ec2-az-c" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t3.micro"
#   key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
#   subnet_id              = aws_subnet.ljc_subnet_c.id         # vincula a subnet direto e gera o IP automático
#   private_ip             = "172.16.30.100"
#   vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
#   user_data              = file("./userdata/nginx_c_3400.sh")

#   tags = {
#     Name         = "Instancia AZ c"
#     "Criado por" = "Terraform"
#   }
# }


terraform {
  backend "s3" {
    bucket = "ljc-tfstate-remote-terraform"
    key    = "tfstate-remote/tfstate"
    region = "us-east-1"
  }
}



# output "aws_instance_e_ssh" {
#   value = [
#     aws_instance.ljc-ec2-az-a.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-a.public_dns}",
#     "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-az-a.public_dns}:3200",
#     aws_instance.ljc-ec2-az-b.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-b.public_dns}",
#     "NGINX_AZB_3300 http://${aws_instance.ljc-ec2-az-b.public_dns}:3300",
#     aws_instance.ljc-ec2-az-c.public_ip,
#     "ssh ubuntu@${aws_instance.ljc-ec2-az-c.public_dns}",
#     "NGINX_AZC_3400 http://${aws_instance.ljc-ec2-az-c.public_dns}:3400"
#   ]
# }

# output "Meu_IP" {
#   value = ["${chomp(data.http.myip.body)}"]
# }

# module "vpc" {
#   source            = "terraform-aws-modules/vpc/aws" # inclusive pode colocar url do git aqui

#   name              = "meu_vpc_nat_gatway"
#   cidr              = "10.0.0.0/16" # uma classe de IP

#   azs               = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   private_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = true
#     Environment = "Dev"
#   }
# }