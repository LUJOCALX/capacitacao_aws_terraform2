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
> >- Criar 3 **subnets**, uma em cada AZ dentro da nova VPC
>> - Criar um **Internet Gateway**
> >- Criar um **Security Group** com regras de acesso a porta 80 e 22
> >- Criar um **EC2** com **nginx** ativo e acessivel pela porta 80
> >- Criar um **bucket S3** sem acesso a internet para servir de repositório para o **terraform.state**

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

>- A pasta **s3tfstate** possui o arquivo main.tf com o código necessário para efetuar a criação via terraform do **bucket S3 sem acesso via internet e com o versionamento ativado.** Este bucket foi criado para permitir o armazenamento e versionamento  remoto do **tfstate** do terraform conforme especificado. 
**Obs:** *Somente após a criação deste bucket é que devem ser criados os demais recursos da infraestrutura. Temos esta dependência para que não haja erro na execução.*

>- Na raiz do repositório, temos mais 7 arquivos deste projeto:
>-**data.tf**
>-**keypair.tf**
>-**security_group.ssh.tf**
>-**vpc.tf**
>-**main.tf**
>-**readme.md**
>-**.gitignore**


>- A pasta **userdada** possui **3** arquivos (**nginx_a_3200.sh**, **nginx_a_3300.sh**, **nginx_a_3400.sh**).
> Estes arquivos são responsáveis pela execução dos comandos de instalação do nginx, execução do start do mesmo, da criação e disponibilização do arquivo customizado de apontamento de portas (**/etc/nginx/sites-enabled/default**), e restart do nginx para iniciar em portas diferentes das defaut da aplicação. No caso deste projeto, o nginx das 3 instâncias EC2 criadas estão subindo nas portas, 3200, 3300 e 3400 respectivamente.

### Pré-requisitos

Possuir as ferramentas e tecnologias já citadas anteriormente, devidamente instaladas e configuradas para o seu sistema operacional e possuir uma conta na aws e no github.

### Utilização:

**1.** Faça o clone do repositorio para sua maquina

>- git clone **https://github.com/LUJOCALX/capacitacao_aws_terraform.git**


### Agradecimentos
- [Weslley](https://github.com/weslleyfs) por todo o apoio;