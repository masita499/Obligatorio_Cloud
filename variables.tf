//////////////////informacion_perfil//////////////////
variable "perfil" {
  type = string
}

//////////////////informacion_ami//////////////////
variable "ami" {
  type=string
}

//////////////////informacion_subnets//////////////////
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

//////////////////informacion_region//////////////////
variable "region" {
  type=string
}

variable "vpc_aws_az_1" {
  default = "us-east-1a"
}

variable "vpc_aws_az_2" {
  default = "us-east-1b"
}

//////////////////informacion_data_base//////////////////
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}


