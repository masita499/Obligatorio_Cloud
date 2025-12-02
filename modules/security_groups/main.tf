# esto se lo crea con el proposito de asingarselo a las ec2.
# a las ec2 solamente le llegara trafico del alb por eso se define aca estas reglas de entrada
resource "aws_security_group" "application_sg" {
  name        = "app_sg_OBLI"
  vpc_id      = var.vpc_id


  ingress {
    description = "HTTP desde ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id] # esto es lo que define que solo permitira trafico del alb
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_sg_OBLI"
  }
}

# el alb solo permite las consultas que toleran las ec2, es decir http porque la web del github no tiene ssl para habilitar el https
resource "aws_security_group" "load_balancer_sg" {
  name        = "load_balancer_sg_OBLI"
  description = "Security Group para el ALB"    
  vpc_id      = var.vpc_id                      # siempre asosiado a nuestro vpc

  ingress {
    description = "HTTP desde Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load_balancer_sg_OBLI"
  }
}

# a la base de datos unicamente se la accede desde las ec2

resource "aws_security_group" "data_base_sg" {
  name = "data_base_sg_OBLI"
  vpc_id = var.vpc_id       # siempre asosiado a nuestro vpc

    ingress {
      from_port = 3306      # solo trafico disponible para el puerto de base de datos mysql
      to_port   = 3306
      protocol = "tcp"
      security_groups = [aws_security_group.application_sg.id]  # unicamente es accedida por las ec2
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
      tags = {
    Name = "data_base_sg"
  }
}