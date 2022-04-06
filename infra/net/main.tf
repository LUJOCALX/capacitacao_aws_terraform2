resource "aws_vpc" "ljc_vpc_tf" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "ljc-vpc-tf"
  }
}

data "aws_availability_zones" "available" {}


# Criação das Subnets publicas nas zonas a, b e c
resource "aws_subnet" "subnet_publica" {
  for_each = {
    "ljc_subnet_pub_a" : ["10.0.101.0/24", "${var.aws_region}a", "ljc_subnet_pub_a"]
    "ljc_subnet_pub_b" : ["10.0.102.0/24", "${var.aws_region}b", "ljc_subnet_pub_b"]
    "ljc_subnet_pub_c" : ["10.0.103.0/24", "${var.aws_region}c", "ljc_subnet_pub_c"]
    # "ljc_subnet_bastion_a" : ["10.0.104.0/24", "${var.aws_region}a", "ljc_subnet_bastion_a"]
  }

  vpc_id                  = aws_vpc.ljc_vpc_tf.id
  cidr_block              = each.value[0]
  availability_zone       = each.value[1]
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = each.value[2] })
}


# Criação das Subnets privadas nas zonas a, b e c
resource "aws_subnet" "subnet_privada" {
  for_each = {
    "ljc_subnet_prv_a" : ["10.0.1.0/24", "${var.aws_region}a", "ljc_subnet_prv_a"]
    "ljc_subnet_prv_b" : ["10.0.2.0/24", "${var.aws_region}b", "ljc_subnet_prv_b"]
    "ljc_subnet_prv_c" : ["10.0.3.0/24", "${var.aws_region}c", "ljc_subnet_prv_c"]
  }
  vpc_id            = aws_vpc.ljc_vpc_tf.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]
  tags              = merge(local.common_tags, { Name = each.value[2] })
}

# Criação da Subnet do bastion host na zona a
resource "aws_subnet" "ljc_subnet_bastion_a" {
  cidr_block              = "10.0.104.0/24"
  vpc_id                  = aws_vpc.ljc_vpc_tf.id
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = "Subnet Bastion" })

}

# Criação do Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}

resource "aws_eip" "eip_ngw" {
}

# Criação do Nat Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip_ngw.id
  subnet_id     = aws_subnet.subnet_publica["ljc_subnet_pub_a"].id

  tags = {
    Name = "aws_nat_gateway_terraform"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


# Criação route table acesso publico
resource "aws_route_table" "rt_publica" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table_terraform publica"
  }
}

# Criação route table acesso privado
resource "aws_route_table" "rt_privada" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "route_table_terraform privada"
  }
}

# Associação das Subnets na Route Table publica
resource "aws_route_table_association" "rtassoc_subnet_publica" {
  for_each       = local.subnet_publica_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.rt_publica.id

}

# Associação das Subnets na Route Table privada
resource "aws_route_table_association" "rtassoc_subnet_privada" {
  for_each       = local.subnet_privada_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.rt_privada.id
}