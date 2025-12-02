# creacion del load balancer
resource "aws_lb" "application_lb" {               # nombre del recurso en terraform
  name               = "application-lb-OBLI"       # nombre del recurso en aws
  internal           = false                       # tiene que ser publico, por eso se pone interal false
  load_balancer_type = "application"               # capa 7 para que balance solo HTTP
  security_groups    = [var.lb_sg_id]              # output del modulo security group
  subnets            = var.public_subnets          # output del modulo networking

  tags = {
    Name = "application_lb_OBLI"                   # nombre amigable  del recurso en aws
  }
}

# creacion del target group 
resource "aws_lb_target_group" "application_tg" {  # nombre del recurso en terraform
  name     = "application-tg"                      # nombre del recurso en aws
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id                            # output del modulo vpc

# es el motor del tg, lo que evalua la salud de las instancias
  health_check {
    enabled             = true                     # que la ec2 este levantada
    path                = "/"                      # analice si la raiz existe la ec2 tambien
    healthy_threshold   = 3                        # maximas instancias sanas que deben haber
    unhealthy_threshold = 2                        # maximas instancias no sanas que deben haber
    timeout             = 5                        # duracion del test en segundos
    interval            = 30                       # cada 30 segundos lanza el test
    matcher             = "200-399"                # de 200 a 399 matches deben haber para determinar si es sana o no
  }

  tags = {
    Name = "application_tg_OBLI"                   # nombre amigable del target group
  }
}

resource "aws_lb_listener" "listener" {             # nombre del recurso en terraform
  load_balancer_arn = aws_lb.application_lb.arn     #asociacion del tg con el alb
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"                               # debe reenviar todo el trafico http (80)  
    target_group_arn = aws_lb_target_group.application_tg.arn  # ese trafico es el check, y se lo manda al alb.
  }
}