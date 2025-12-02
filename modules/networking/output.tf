# crea el punto de entrada para las otras varibales que quieran asignar subredes publicas o privadas.
# aca asocia dos objetos en uno solo 
output "public_subnets" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

# aca asocia dos objetos en uno solo 
output "private_subnets" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
}
# aca define el output que usaran las otras variables como punto de partida para identificar al NATGW 
output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}
# aca define el output que usaran las otras variables como punto de partida para identificar al IGW
output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}
