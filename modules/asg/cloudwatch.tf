# Log Group donde se almacenarían los logs de la aplicación.
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ecs/ecommerce-app"
  retention_in_days = 7
}


# Política que define qué debe hacer el Auto Scaling Group cuando se dispare la alarma.
# En este caso, se incrementa la capacidad del ASG en +1 instancia EC2.
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

# Alarma que monitorea el valor promedio de CPU de las instancias del ASG.
# Si la CPU supera el threshold configurado, se activa la acción de escalado automático.
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "asg-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 5

  # Identifica qué instancias debe evaluar: todas las pertenecientes al ASG.
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto_scaling_group.name
  }

  # Acción a ejecutar cuando la alarma cambia a estado ALARM.
  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}
