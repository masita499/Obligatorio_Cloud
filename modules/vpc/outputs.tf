output "vpc_id" {
  description = "ID de la VPC creada por el módulo"
  value       = aws_vpc.vpc.id
}

# output "vpc_arn" {
#   description = "ARN de la VPC"
#   value       = aws_vpc.this.arn
# }

# output "vpc_cidr_block" {
#   description = "CIDR de la VPC"
#   value       = aws_vpc.this.cidr_block
# }
