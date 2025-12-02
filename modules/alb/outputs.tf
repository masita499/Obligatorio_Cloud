# Define simplemente las variables que los otros modulos usaron como entrada para sus variables
# En esto caso es el ARN del target group
output "target_group_arn" {
  value       = aws_lb_target_group.application_tg.arn
}
# Y aqui es el link alb del dns con registro (A) que usamos para confirmar si la aplicacion dentro de la ec2 funciona
output "lb_dns_name" {
  value       = aws_lb.application_lb.dns_name
}
