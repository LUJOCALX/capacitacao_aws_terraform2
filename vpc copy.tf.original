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