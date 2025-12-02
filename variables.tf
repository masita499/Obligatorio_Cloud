# El unico proposito de todo el contenido en este archivo, es definir "a prepo" la naturaleza de todas las variables
# que usara el archivo Main y los distintos Modulos.

# ----------------------------------------------------------------------------------------------------------------------------
# Con exepcion de estas: Terraform es flexible, cuando explicitamente no se le asigna un valor a "type" terraform se fija en 
# "default" y como el contenido de "default" esta entre comillas, terraform ya sabe que es de typo string.

# ¿Por que se lo definio aca? Por comodidad a la hora de escribir el codigo, y tambien para demostrar la versatilidad de los
# conocimientos aprendidos y demostrar que hay muchos caminos para llegar a roma.

variable "vpc_aws_az_1" {
  default = "us-east-1a"
}

variable "vpc_aws_az_2" {
  default = "us-east-1b"
}
# ----------------------------------------------------------------------------------------------------------------------------

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


