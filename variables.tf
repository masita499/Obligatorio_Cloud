# El unico proposito de todo el contenido en este archivo, es definir "a prepo" la naturaleza de todas las variables
# que usara el archivo Main y los distintos Modulos.

variable "vpc_aws_az_1" {
  type = string
}

variable "vpc_aws_az_2" {
  type = string
}


variable "perfil" {
  type = string
}

variable "ami" {
  type=string
}

variable "vpc_cidr" {
    type=string
}

variable "private_subnet_1" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "public_subnet_1" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

variable "region" {
  type=string
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

variable "instance_type" {
  type    = string
}

variable "min_size" {
  type    = number
}
variable "max_size" {
  type    = number
}
variable "desired_capacity" {
  type    = number
}