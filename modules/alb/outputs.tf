output "target_group_arn" {
  value       = aws_lb_target_group.application_tg.arn
}

output "lb_dns_name" {
  value       = aws_lb.application_lb.dns_name
}
