resource "aws_security_group" "app_sg" {
  name        = "app_sg_OBLI"
  description = "SG para instancias de frontend"
  vpc_id      = aws_vpc.vpc_1.id

  # Solo recibe tráfico del ALB
  ingress {
    description = "HTTP desde ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.laod_balancer_sg.id] 
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

resource "aws_security_group" "laod_balancer_sg" {
  name        = "laod_balancer_sg_OBLI"
  description = "Security Group para el ALB"
  vpc_id      = aws_vpc.vpc_1.id

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
    Name = "laod_balancer_sg_OBLI"
  }
}