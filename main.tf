//////////////////modulo_vpc//////////////////
module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_name         = "vpc_Obligatorio"
}

//////////////////modulo_networking//////////////////
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

//////////////////modulo_application_ld//////////////////
module "alb" {
  source           = "./modules/alb"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.networking.public_subnets
  lb_sg_id         = module.security_groups.lb_sg_id
}

//////////////////modulo_auto_scaling_group//////////////////
module "asg" {
  source           = "./modules/asg"
  ami              = var.ami
  app_sg_id        = module.security_groups.app_sg_id
  target_group_arn = module.alb.target_group_arn
  private_subnets  = module.networking.private_subnets

  db_endpoint      = module.db.db_endpoint
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password

}

//////////////////modulo_security_groups//////////////////
module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id


}

//////////////////modulo_data_base//////////////////
module "db" {
  source           = "./modules/db"
 # vpc_id           = module.vpc.vpc_id
  private_subnets  = module.networking.private_subnets
  db_sg_id         = module.security_groups.db_sg_id
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}