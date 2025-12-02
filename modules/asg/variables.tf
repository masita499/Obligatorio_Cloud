# algunas variables toman el valor del archivo tfvars y otras son outputs de modulos como "security group", "alb" y "networking"

# variable que toma valor de tfvars
variable "ami" {
  type = string
}

# variable que toma valor de tfvars
variable "instance_type" {
  type    = string
}

# variable que toma valor de security group
variable "app_sg_id" {
  type = string
}
# variable que toma valor de networking
variable "private_subnets" {
  type = list(string)                     # esta varible es de tipo array, porque contine dos subredes en un solo objeto.
}
# variable que toma valor de alb
variable "target_group_arn" {
  type = string
}
# variable que toma valor de tfvars
variable "min_size" {
  type    = number
}
# variable que toma valor de tfvars
variable "max_size" {
  type    = number
}
# variable que toma valor de tfvars
variable "desired_capacity" {
  type    = number
}
# variable que toma valor de tfvars
variable "db_name" {
  type = string
}
# variable que toma valor de tfvars
variable "db_username" {
  type = string
}
# variable que toma valor de tfvars
variable "db_password" {
  type = string
}
# variable que toma valor de tfvars
variable "db_endpoint" {
  type = string
}
