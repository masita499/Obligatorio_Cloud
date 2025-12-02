# se crean las subredes que posteriormente seran usadas como outputs para otros modulos

# Aca se define la subnet para luego ser asociada con su otro par dentro de un mismo objeto.
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id           #debe estar en el mismo vpc que su par
  cidr_block              = var.public_subnet_1   
  availability_zone       = var.vpc_aws_az_1      # debe tener un AZ caracteristico, ya que esto es una de las principales diferencias
  map_public_ip_on_launch = true                  # asignacion automatica de IP publica

  tags = {
    Name = "public-subnet-1"
  }
}

# Aca se define la subnet para luego ser asociada con su otro par dentro de un mismo objeto.
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc_id             # debe estar en el mismo vpc que su par
  cidr_block              = var.public_subnet_2
  availability_zone       = var.vpc_aws_az_2       # debe tener un AZ caracteristico, ya que esto es una de las principales diferencias
  map_public_ip_on_launch = true                   # asignacion automatica de IP publica

  tags = {
    Name = "public-subnet-2"
  }
}

# creacion del internt gateway, este siempre esta asociado a un vpc y es publico
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "terraform-gw"
  }
}

# creacion de la tabla de rutas publica, donde estaran las subnets
resource "aws_route_table" "route_table_pub" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id    # esto es lo que la defina como publica.
  }
  tags = {
    Name = "public-route-table"
  }
}

# aca se define la asociacion de las dos subnets publicas a la tabla de rutas publica
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route_table_pub.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route_table_pub.id
}


# exactamente lo mismo a nivel conceptual pero, para las privadas.
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_1
  availability_zone       = var.vpc_aws_az_1
  map_public_ip_on_launch = false
  tags = {
    Name = "terraform_private_subnet_1_OBLI"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_2
  availability_zone       = var.vpc_aws_az_2
  map_public_ip_on_launch = false
  tags = {
    Name = "terraform_private_subnet_2_OBLI"
  }
}

# se crea una direccion ip publica y estatica para asignarle al nat gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
    Name = "nat_eip_OBLI"
  }
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id             # parte en donde se le asocia la ip estatica al nat gw
  subnet_id     = aws_subnet.public_subnet_1.id  # corresponde asociarla a la subnet publica para que de ip en ese rango

  tags = {
    Name = "nat_gateway_OBLI"
  }
}

# se crea una tabla de rutas privadas para que la usen la ec2 y el natwg
resource "aws_route_table" "route_table_priv" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id   # se asocia el nat gw a la route table privada
  }

  tags = {
    Name = "private_route_table_OBLI"
  }
}
# como resultado : todo el direccionamineto saliente de las subnets privadas salen por el natgw
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.route_table_priv.id
  }

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.route_table_priv.id
}