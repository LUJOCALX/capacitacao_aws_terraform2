# Capacitação Terraform AWS
</h3>
<p align="center">
 <a href="#objetivo">Objetivo</a> |
 <a href="#desafio">Desafio</a> |
 <a href="#desenvolvedor">Desenvolvedor</a> |
 <a href="#tecnologias">Tecnologias</a> |
 <a href="#explicação">Explicação</a> |
 <a href="#utilização">Utilização</a> |
 <a href="#agradecimentos">Agradecimentos</a>
</p>


## Objetivo

- Aplicar os conhecimentos adquiridos nos treinamentos sobre Terraform e AWS.

## Desafio

- Disponibilizar a infraestrutura proposta a seguir na AWS utilizando o Terraform. Segue abaixo as especificações "desejadas":


>> - Criar uma **VPC** não default
>>- Criar 3 **subnets**, uma em cada AZ dentro da nova VPC
>> - Criar um **Internet Gateway**
>>- Criar um **Security Group** com regras de acesso a porta 80 e 22
>>- Criar um **EC2** com **nginx** ativo e acessivel pela porta 80
>>- Criar um **bucket S3** sem acesso a internet para servir de repositório para o **terraform.state**

### Desenvolvedor

|[<img src="https://avatars.githubusercontent.com/u/67441115?v=4" width=115 > <br> <sub> Lucio José Cabianca </sub>](https://github.com/LUJOCALX)| 
| -------- |

## Tecnologias

Plataformas e Tecnologias que utilizamos para desenvolver este projeto:

- [AWS](https://aws.amazon.com/)
- [Linux (Ubuntu)](https://ubuntu.com/)
- [Git](https://www.github.com/)
- [VSCode](https://code.visualstudio.com/download)

## Explicação

- A pasta **s3tfstate** possui o arquivo main.tf com o código necessário para efetuar a criação via terraform do **bucket S3 sem acesso via internet e com o versionamento ativado.** Este bucket foi criado para permitir o armazenamento e versionamento  remoto do **tfstate** do terraform conforme especificado. 
**Obs:** *Somente após a criação deste bucket é que devem ser criados os demais recursos da infraestrutura. Temos esta dependência para que não haja erro na execução.*

```
provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "ljc-tfstate-remote-terraform" {

  bucket = "ljc-tfstate-remote-terraform"

  tags = {

    Descricao = "Armazena o terraform tfstate remotamente"
    UsadoPor  = "Terraform"
    Owner     = "ljc"
  }
}

resource "aws_s3_bucket_versioning" "versionamento" {
  bucket = aws_s3_bucket.ljc-tfstate-remote-terraform.id

  versioning_configuration {

    status = "Enabled"

  }
}

```

- Na raiz do repositório, temos mais 7 arquivos deste projeto:
>
**data.tf**
>
```
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
```
>
**keypair.tf**
>
```
resource "aws_key_pair" "deployer" {
  key_name   = "curso_criacao_ambiente_terraform"
  public_key = file("C:/users/lucio/.ssh/id_rsa.pub")
}
```
>
**security_group.ssh.tf**
>
```
# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/ssh#input_auto_computed_egress_rules
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# ingress = [  # inbound - de fora (internet) para dentro da da maquina
# egress = [ # outbound - de dentro nda maquina, para fora (internet)


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_vpc_terraform"
  description = "Allow SSH inbound traffic criado pelo terraform VPC"
  vpc_id      = aws_vpc.ljc_vpc_tf.id

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
    Name = "allow_ssh"
  }
}
```
**vpc.tf**
```
resource "aws_vpc" "ljc_vpc_tf" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ljc-vpc-tf"
  }
}

resource "aws_subnet" "ljc_subnet_a" {
  vpc_id                  = aws_vpc.ljc_vpc_tf.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ljc-subnet-tf_a"
  }
}

resource "aws_subnet" "ljc_subnet_b" {
  vpc_id                  = aws_vpc.ljc_vpc_tf.id
  cidr_block              = "172.16.20.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ljc-subnet-tf_b"
  }
}

resource "aws_subnet" "ljc_subnet_c" {
  vpc_id                  = aws_vpc.ljc_vpc_tf.id
  cidr_block              = "172.16.30.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "ljc-subnet-tf_c"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route_table_terraform"
  }
}

resource "aws_route_table_association" "rtassoc_subnet_aza" {
  subnet_id      = aws_subnet.ljc_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "rtassoc_subnet_azb" {
  subnet_id      = aws_subnet.ljc_subnet_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "rtassoc_subnet_azc" {
  subnet_id      = aws_subnet.ljc_subnet_c.id
  route_table_id = aws_route_table.public.id
}
```
**main.tf**
```
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

```

**readme.md**
```

```

**.gitignore**
```

# Created by https://www.toptal.com/developers/gitignore/api/terraform,ansible,java,linux,macos
# Edit at https://www.toptal.com/developers/gitignore?templates=terraform,ansible,java,linux,macos

### Ansible ###
*.retry

### Java ###
# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files #
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs, see http://www.java.com/en/download/help/error_hotspot.xml
hs_err_pid*

### Linux ###
*~

# temporary files which can be created if a process still has a handle open of a deleted file
.fuse_hidden*

# KDE directory preferences
.directory

# Linux trash folder which might appear on any partition or disk
.Trash-*

# .nfs files are created when an open file is removed but is still being accessed
.nfs*

### macOS ###
# General
.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon


# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

### Terraform ###
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log

# Exclude all .tfvars files, which are likely to contain sentitive data, such as
# password, private keys, and other secrets. These should not be part of version
# control as they are data points which are potentially sensitive and subject
# to change depending on the environment.
#
*.tfvars

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc

# End of https://www.toptal.com/developers/gitignore/api/terraform,ansible,java,linux,macos
```
>- A pasta **userdada** possui **3** arquivos (**nginx_a_3200.sh**, **nginx_a_3300.sh**, **nginx_a_3400.sh**).
> Estes arquivos são responsáveis pela execução dos comandos de instalação do nginx, execução do start do mesmo, da criação e disponibilização do arquivo customizado de apontamento de portas (**/etc/nginx/sites-enabled/default**), e restart do nginx para iniciar em portas diferentes das defaut da aplicação. No caso deste projeto, o nginx das 3 instâncias EC2 criadas estão subindo nas portas, 3200, 3300 e 3400 respectivamente.

```
#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx

sudo echo "##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#
server {
        listen 3200 default_server;
        listen [::]:3200 default_server;

        # SSL configuration
        #
        # listen 443 ssl default_server;
        # listen [::]:443 ssl default_server;
        #
        # Note: You should disable gzip for SSL traffic.
        # See: https://bugs.debian.org/773332
        #
        # Read up on ssl_ciphers to ensure a secure configuration.
        # See: https://bugs.debian.org/765782
        #
        # Self signed certs generated by the ssl-cert package
        # Don't use them in a production server!
        #
        # include snippets/snakeoil.conf;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri  \$uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        #location ~ \.php$ {
        #       include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
        #       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #       deny all;
        #}
}


# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
#server {
#       listen 80;
#       listen [::]:80;
#
#       server_name example.com;
#
#       root /var/www/example.com;
#       index index.html;
#
#       location / {
#               try_files \$uri \$uri =404;
#       }
#}
" > /home/ubuntu/default3200

sudo cp /etc/nginx/sites-enabled/default /home/ubuntu/default.original
sudo cp /home/ubuntu/default3200 /etc/nginx/sites-enabled/default
sudo chmod 644 /etc/nginx/sites-enabled/default
sudo rm /home/ubuntu/default3200
sudo systemctl restart nginx
```

### Pré-requisitos

Possuir as ferramentas e tecnologias já citadas anteriormente, devidamente instaladas e configuradas para o seu sistema operacional e possuir uma conta na aws e no github.

### Utilização:

**1.** Faça o clone do repositorio para sua maquina

>- git clone **https://github.com/LUJOCALX/capacitacao_aws_terraform.git**


### Agradecimentos
- [Weslley](https://github.com/weslleyfs) por todo o apoio;