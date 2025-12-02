# exporta como varible de output para el modulo de asg , el link para acceder a la base de datos.
output "db_endpoint" {
  value = aws_db_instance.instancia_db.address
}
