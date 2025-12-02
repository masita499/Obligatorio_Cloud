# crea esta variable de salida como entrada hacia los otros modulos que quieran usar el asg para asociarlo.
output "asg_name" {
  value = aws_autoscaling_group.auto_scaling_group.name
}

