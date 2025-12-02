# variable necesaria para crear todos los recursos de la infraestructura y poder asociarlos a nuestro vpc

output "vpc_id" {
  description = "ID de la VPC creada por el módulo"
  value       = aws_vpc.vpc.id                         # el encargado de todo eso es el identificador unico del vpc
}

