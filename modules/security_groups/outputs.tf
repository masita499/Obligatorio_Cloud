output "app_sg_id" {
  value = aws_security_group.application_sg.id
}

output "lb_sg_id" {
  value = aws_security_group.load_balancer_sg.id
}

output "db_sg_id" {
  value = aws_security_group.data_base_sg.id
}