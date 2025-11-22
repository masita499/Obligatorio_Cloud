resource "aws_lb" "application_lb" {
  name               = "application-lb-OBLI"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.laod_balancer_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "application_lb_OBLI"
  }
}

resource "aws_lb_target_group" "application_tg" {
  name     = "application-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_1.id

  health_check {
    enabled             = true
    path                = "/index.html"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

  tags = {
    Name = "application_tg_OBLI"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_tg.arn
  }
}