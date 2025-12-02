# Usa como variables los outputs de los modulos "vpc", "security groups" y "networking"

# Output del modulo vpc
variable "vpc_id" {
  type = string
}

# Output del modulo security group
variable "lb_sg_id" {
  type = string
}

# Output del modulo networking
variable "public_subnets" {
  type = list(string)             #  esta varible es de tipo array, porque contine dos subredes en un solo objeto.
}
