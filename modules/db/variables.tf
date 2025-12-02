# usa como variables los outpus de "security groups" y "networking".
variable "private_subnets" {  # output de networking
  type = list(string)         # esto es de tipo array que contiene dos subnets en un solo objeto.
}
variable "db_sg_id" {         # output de security group
    type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

