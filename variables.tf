variable "perfil" {
  type = string
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

variable "vpc_aws_az_1" {
  default = "us-east-1a"
}

variable "vpc_aws_az_2" {
  default = "us-east-1b"
}

variable "region" {
  type=string
}

variable "ami" {
  type=string
}

variable "vpc_cidr" {
    type=string
}