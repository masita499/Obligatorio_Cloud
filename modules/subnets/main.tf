resource "aws_subnet" "public_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_1
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1" }
}

resource "aws_subnet" "public_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_2
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-2" }
}

resource "aws_subnet" "private_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_1
  availability_zone = var.vpc_aws_az_2
  tags = { Name = "private-subnet-1" }
}

resource "aws_subnet" "private_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_2
  availability_zone = var.vpc_aws_az_2
  tags = { Name = "private-subnet-2" }
}
