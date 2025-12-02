# Aqui sucede unicamente la invocacion de los modulos creados anteriormente, se necesitan tambien sus dependecias.
# Basicamente aca se resume toda la infraestructura del proyecto.
# La verdadera infra son los modulos, ahi sucede todas las intrucciones.

# Llamado del modulo vpc y sus dependencias.
module "vpc" {
  source           = "./modules/vpc"

  vpc_cidr         = var.vpc_cidr
  vpc_name         = "vpc_Obligatorio"
}

# Llamado del modulo networking y sus dependencias.
module "networking" {
  source           = "./modules/networking"

  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  vpc_aws_az_1     = var.vpc_aws_az_1
  vpc_aws_az_2     = var.vpc_aws_az_2
  vpc_id           = module.vpc.vpc_id
}

# Llamado del modulo alb y sus dependencias.
module "alb" {
  source           = "./modules/alb"

  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.networking.public_subnets
  lb_sg_id         = module.security_groups.lb_sg_id
}

# Llamado del modulo asg y sus dependencias.
module "asg" {
  source           = "./modules/asg"

  ami              = var.ami
  app_sg_id        = module.security_groups.app_sg_id
  target_group_arn = module.alb.target_group_arn
  private_subnets  = module.networking.private_subnets
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  instance_type = var.instance_type
  
  db_endpoint      = module.db.db_endpoint
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password


}

# Llamado del modulo security groups y sus dependencias.
module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id


}

# Llamado del modulo db y sus dependencias
module "db" {
  source           = "./modules/db"

  private_subnets  = module.networking.private_subnets
  db_sg_id         = module.security_groups.db_sg_id
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}
