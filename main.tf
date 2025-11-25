module "vpc" {
  source     = "./modules/vpc"
  name = "vpc_1"
}

module "networking" {
  source           = "./modules/networking"
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  vpc_id           = module.vpc.vpc_id
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.networking.public_subnets
  sg_alb_id   = module.security.sg_alb
}

module "asg" {
  source            = "./modules/asg"
  subnet_ids        = module.networking.private_subnets
  sg_app_id         = module.security.sg_app
  target_group_arn  = module.alb.target_group_arn
  ami               = var.ami
}
