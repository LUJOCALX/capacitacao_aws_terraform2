locals {
  # Variável para criação da associação das subnets publicas
  subnet_publica_ids = { for k, v in aws_subnet.subnet_publica : v.tags.Name => v.id }

  # Variável para criação da associação das subnets privadas
  subnet_privada_ids = { for k, v in aws_subnet.subnet_privada : v.tags.Name => v.id }

  # Tags comuns dos serviços
  common_tags = {
    Project   = "Capacitação AWS com Terraform"
    CreatedAt = "2022-03-28"
    ManagedBy = "Terraform"
    Owner     = "Lucio José Cabianca"
  }
}