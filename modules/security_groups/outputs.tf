# crea el punto de partida para las variables de los otros modulos, por ejemplo el asg para crear las ec2, db o alb

# output para el trafico que reciben las ec2 del alb del launch template.
output "app_sg_id" {
  value = aws_security_group.application_sg.id
}

# output para el direccionamiento del trafico del load balancer.
output "lb_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

# output para la seguridad de la base de datos, al ser accedidas unicamente desde las ec2.
output "db_sg_id" {
  value = aws_security_group.data_base_sg.id
}