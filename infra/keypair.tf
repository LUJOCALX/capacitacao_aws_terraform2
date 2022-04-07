resource "aws_key_pair" "deployer" {
  key_name   = "curso_criacao_ambiente_terraform"
  public_key = file("C:/users/lucio/.ssh/id_rsa.pub")
}

