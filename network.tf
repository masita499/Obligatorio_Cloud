resource "aws_vpc" "vpc_1" {
    cidr_block =var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

  tags = {
    Name = "vpc-1"
  }
}

///////////////////////PUBLICO//////////////////////////////

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.vpc_aws_az_1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.vpc_aws_az_2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    Name = "terraform-gw"
  }
}

resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table_pub.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table_pub.id
}


///////////////////////PRIVADO//////////////////////////////


resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_1
  availability_zone       = var.vpc_aws_az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "terraform_private_subnet_1_OBLI"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.private_subnet_2
  availability_zone       = var.vpc_aws_az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "terraform_private_subnet_2_OBLI"
  }
}

resource "aws_eip" "nat_eip" {
    tags = {
    Name = "nat_eip_OBLI"
  }
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat_gateway_OBLI"
  }
}

resource "aws_route_table" "route_table_priv" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_route_table_OBLI"
  }
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.route_table_priv.id
  }

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_table_priv.id
}