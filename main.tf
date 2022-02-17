provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ljc-ec2-az-a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  subnet_id              = aws_subnet.ljc_subnet_a.id         # vincula a subnet direto e gera o IP automático
  private_ip             = "172.16.10.100"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  user_data              = file("./userdata/nginx_a_3200.sh")

  #<<EOT
  # #cloud-config
  # # update apt on boot
  # package_update: true
  # # install nginx
  # packages:
  # - nginx
  # write_files:
  # - content: |
  #     <!DOCTYPE html>
  #     <html>
  #     <head>
  #       <title>StackPath - Amazon Web Services Instance</title>
  #       <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  #       <style>
  #         html, body {
  #           background: #000;
  #           height: 100%;
  #           width: 100%;
  #           padding: 0;
  #           margin: 0;
  #           display: flex;
  #           justify-content: center;
  #           align-items: center;
  #           flex-flow: column;
  #         }
  #         img { width: 250px; }
  #         svg { padding: 0 40px; }
  #         p {
  #           color: #fff;
  #           font-family: 'Courier New', Courier, monospace;
  #           text-align: center;
  #           padding: 10px 30px;
  #         }
  #       </style>
  #     </head>
  #     <body>
  #       <img src="https://www.stackpath.com/content/images/logo-and-branding/stackpath-logo-standard-screen.svg">
  #       <p>This request was proxied from <strong>Amazon Web Services</strong></p>
  #     </body>
  #     </html>
  #   path: /usr/share/app/index.html
  #   permissions: '0644'
  # runcmd:
  # - cp /usr/share/app/index.html /usr/share/nginx/html/index.html
  # EOT

  tags = {
    Name         = "Instancia AZ a"
    "Criado por" = "Terraform"
  }
}

resource "aws_instance" "ljc-ec2-az-b" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  subnet_id              = aws_subnet.ljc_subnet_b.id         # vincula a subnet direto e gera o IP automático
  private_ip             = "172.16.20.100"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  user_data              = file("./userdata/nginx_b_3300.sh")

  tags = {
    Name         = "Instancia AZ b"
    "Criado por" = "Terraform"
  }
}

resource "aws_instance" "ljc-ec2-az-c" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = "curso_criacao_ambiente_terraform" # key chave publica cadastrada na AWS 
  subnet_id              = aws_subnet.ljc_subnet_c.id         # vincula a subnet direto e gera o IP automático
  private_ip             = "172.16.30.100"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  user_data              = file("./userdata/nginx_c_3400.sh")

  tags = {
    Name         = "Instancia AZ c"
    "Criado por" = "Terraform"
  }
}




# data "aws_caller_identity" "current" {}

# resource "aws_s3_bucket" "ljc-tfstate-remote-terraform" {

# bucket = "ljc-tfstate-remote-terraform"

# # versioning {

# #     enabled = true

# # }

# tags = {

#     Descricao = "Armazena o terraform tfstate remotamente"
#     UsadoPor = "Terraform"
#     Owner = "ljc"
# }
# }

# output "remote_state_bucket" {

#     value = aws_s3_bucket.remote-state.bucket
# }

# output "remote_state_bucket_arn" {

#     value = aws_s3_bucket.remote-state.arn
# }

# terraform {
#   backend "s3" {
#     bucket = "${aws_s3_bucket.remote-state.bucket}"
#     key    = "tfstate_remoto/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

# terraform {
#   backend "s3" {}
# }

# data "terraform_remote_state" "state" {
#   backend = "s3"
#   config {
#     bucket     = aws_s3_bucket.remote-state.bucket
#     region     = "us-east-1"
#     key        = "tfstate-remoto/tfstate/terraform.tfstate"
#   }
# }


terraform {
  backend "s3" {
    bucket = "ljc-tfstate-remote-terraform"
    key    = "tfstate-remote/tfstate"
    region = "us-east-1"
  }
}

output "aws_instance_e_ssh" {
  value = [
    aws_instance.ljc-ec2-az-a.public_ip,
    "ssh ubuntu@${aws_instance.ljc-ec2-az-a.public_dns}",
    "NGINX_AZA_3200 http://${aws_instance.ljc-ec2-az-a.public_dns}:3200",
    aws_instance.ljc-ec2-az-b.public_ip,
    "ssh ubuntu@${aws_instance.ljc-ec2-az-b.public_dns}",
    "NGINX_AZB_3300 http://${aws_instance.ljc-ec2-az-b.public_dns}:3300",
    aws_instance.ljc-ec2-az-c.public_ip,
    "ssh ubuntu@${aws_instance.ljc-ec2-az-c.public_dns}",
    "NGINX_AZC_3400 http://${aws_instance.ljc-ec2-az-c.public_dns}:3400"
  ]
}

output "Meu_IP" {
  value = ["${chomp(data.http.myip.body)}"]
}