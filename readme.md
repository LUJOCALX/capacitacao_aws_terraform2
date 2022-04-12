# Capacitação Terraform AWS (Parte 2)
</h3>
<p align="center">
 <a href="#objetivo">Objetivo</a> |
 <a href="#desafio">Desafio</a> 
 |
 <a href="#tecnologias">Tecnologias</a> |
 <a href="#pré-requisitos">Pré-requisitos</a> |
 <a href="#utilização">Utilização</a> |

</p>

***
## Objetivo
***
- Aplicar os conhecimentos adquiridos nos treinamentos sobre Terraform e AWS.
***
## Desafio
***
#### Disponibilizar a infraestrutura proposta a seguir na AWS utilizando o Terraform. Segue abaixo as especificações "desejadas":
***
- Criar uma **VPC** não default
- Criar 3 **subnets publicas**, uma em cada AZ dentro da nova VPC
- Criar 3 **subnets privadas**, uma em cada AZ dentro da nova VPC
- Criar 1 **Internet Gateway**
- Criar 1 **Nat Gateway**
- Criar 2 **Security Groups**
- Criar 3 **Instâncias EC2** Utilizando a **AMI** da amazon **linux**, instalar o **apache** e liberar o acesso conforme abaixo:
- Alterar o arquivo /var/www/html/index.htm adicionando o texto "Servidor Apache 1", e subir o serviço na porta 3001
- Alterar o arquivo /var/www/html/index.htm adicionando o texto "Servidor Apache 2", e subir o serviço na porta 3002
- Alterar o arquivo /var/www/html/index.htm adicionando o texto "Servidor Apache 3", e subir o serviço na porta 3003

**Obs:** ***As 3 instâncias devem estar deployadas uma em cada subrede privada com acesso a internet somente para a instalação de pacotes. O apache não deve mostrar a sua versão aos clientes através do nmap ou inspect via browser. Desabilitar a versão 1.0 http e configurar no S.O. o tcp reuse e tcp port recycle (que serve para reutilizar as portas TCP do Kernel)***

- Criar 1 instância com **nginx** em uma subrede publica que será utilizado como loadbalancer. Esta instância deverá ter acesso full a internet e acesso as portas de serviço das EC2 com apache via **Security Group**. Configurar o **loadbalancer** no modo random e acessível via porta 8080, durante a apresentação o acesso deve ser feito no IP publico desta EC2 para validar o funcionamento do balancer.

- Criar 1 **Bucket S3** sem acesso a internet para servir de repositório para o **tfstate**.

### Obrigatório!

- As EC2 devem ser deployadas utilizando "count através do módulo criado no ultimo desafio;
- As subnets devem ser criadas usando **"count"** ou **"for_each"**;
- Necessário ter **outputs** dos ips privados das 3 EC2 com apache e do ip publico do do EC2 com nginx;
Utilizar **dynamic block** para para o provisionamento de um item de sua escolha da infraestrutura.

- Rodar tudo do seu computador pessoal, subir no seu **git** pessoal e montar uma apresentação final do seu código em funcionamento.

- Mostrar o git, rodar o **terraform apply** e mostrar a infra sendo provisionada na AWS e acessar o ip do balancer demonstrando o funcionamento.


***
## Tecnologias
***
Plataformas e Tecnologias que utilizamos para desenvolver este projeto:

- [AWS](https://aws.amazon.com/)
- [Linux (Ubuntu)](https://ubuntu.com/)
- [Git](https://www.github.com/)
- [Git Bash](https://git-scm.com)
- [VSCode](https://code.visualstudio.com/download)
- [Terraform](https://www.terraform.io/)
- [Apache](https://www.apache.org/)
- [Nginx](https://www.nginx.com/)
- [Teraform](https://registry.terraform.io/) 
***

### Pré-requisitos
***
Possuir as ferramentas e tecnologias já citadas anteriormente, devidamente instaladas e configuradas para o seu sistema operacional e possuir uma conta na aws e no github.
***
### Utilização:
***
**1.** Faça o clone do [Repositório](https://github.com/LUJOCALX/capacitacao_aws_terraform2) para seu ambiente

- Para isso utilize o comando:
>git clone https://github.com/LUJOCALX/capacitacao_aws_terraform2.git

- Altere valores de referência de chaves privadas, publicas, AMIS, paths de arquivos e tags, para adequação ao seu ambiente.  

- Abra o gitbash na pasta s3tfstate e execute o **terraform init**, **terraform plan**, **terraform apply** para gerar o **bucket S3** necessário para armazenar e versionar o **tfstate**.

- Na pasta **infra** execute os mesmos comandos (**terraform init**, **terraform plan**, **terraform apply** ) para a criação dos demais componentes da infraestrutura e aplicação do projeto.

- Os outputs gerados trarão os links e informações para acesso as instâncias do Nignx, Apache e bastion do projeto, para dar suporte a validação da funcionalidade dos componentes do projeto.