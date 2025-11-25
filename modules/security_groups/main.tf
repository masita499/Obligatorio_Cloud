resource "aws_security_group" "application_sg" {
  name        = "app_sg_OBLI"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP desde ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id] 
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

resource "aws_security_group" "load_balancer_sg" {
  name        = "load_balancer_sg_OBLI"
  description = "Security Group para el ALB"
  vpc_id      = var.vpc_id

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

resource "aws_security_group" "data_base_sg" {
  name = "data_base_sg_OBLI"
  vpc_id = var.vpc_id

    ingress {
      from_port = 3306
      to_port   = 3306
      protocol = "tcp"
      security_groups = [aws_security_group.application_sg.id]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}