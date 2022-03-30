resource "aws_vpc" "ljc_vpc_tf" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ljc-vpc-tf"
  }
}

# Criação das Subnets publicas nas zonas a, b e c
resource "aws_subnet" "subnet_publica" {
  for_each = {
    "ljc_subnet_pub_a" : ["10.0.101.0/24", "${var.aws_region}a", "ljc_subnet_pub_a"]
    "ljc_subnet_pub_b" : ["10.0.102.0/24", "${var.aws_region}b", "ljc_subnet_pub_b"]
    "ljc_subnet_pub_c" : ["10.0.103.0/24", "${var.aws_region}c", "ljc_subnet_pub_c"]
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


# Criação do Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ljc_vpc_tf.id

  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}

# Criação do Nat Gateway
resource "aws_nat_gateway" "ngw" {
  connectivity_type = "private"
  for_each          = local.subnet_privada_ids
  subnet_id         = each.value
  tags = {
    Name = "aws_nat_gateway_terraform"
  }
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


# # Criação route table acesso privado
# resource "aws_route_table" "rt_privada" {
#   vpc_id = aws_vpc.ljc_vpc_tf.id

#   route {
#     cidr_block = "0.0.0.0/0"
# #    gateway_id = aws_nat_gateway.ngw.id
#   }

#   tags = {
#     Name = "route_table_terraform privada"
#   }
# }

# Associação das Subnets na Route Table publica
resource "aws_route_table_association" "rtassoc_subnet_publica" {
  for_each       = local.subnet_publica_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.rt_publica.id
}

# # Associação das Subnets na Route Table privada
# resource "aws_route_table_association" "rtassoc_subnet_privada" {
#   for_each = local.subnet_privada_ids
#   subnet_id      = each.value
#   route_table_id = aws_route_table.rt_privada.id
# }