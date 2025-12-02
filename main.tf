# Creacion del Modulo VPC.
module "vpc" {
  source           = "./modules/vpc"

  vpc_cidr         = var.vpc_cidr
  vpc_name         = "vpc_Obligatorio"
}

# Creacion del Modulo Networking: Usa recursos de las Subredes, Zonas de Disponibilidad y VPC.
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

# Creacion del modulo ALB: Usa recursos de subred, Security Group y VPC.
module "alb" {
  source           = "./modules/alb"

  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.networking.public_subnets
  lb_sg_id         = module.security_groups.lb_sg_id
}

# Creacion del modulo ASG: Usa recursos de Ami, Security Group, Target Group, Subred.
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

# El ASG no está creando ni albergando la base de datos, sino que está recibiendo las credenciales 
# y el punto de acceso de la base de datos como variables de entrada.
# Esto se hace para que las instancias de EC2 lanzadas por el ASG sepan cómo y dónde conectarse a la base de datos.

}

# Creacion del Modulo Security Groups: Usa el recurso de VPC para asociarse a el.
module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id


}

# Creacion del Modulo de la Base de Datos: Usa recursos de subred y Security Group.
module "db" {
  source           = "./modules/db"

  private_subnets  = module.networking.private_subnets
  db_sg_id         = module.security_groups.db_sg_id
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}
#UNA OBSERVACION DIGNA DE COMENTAR:
# En los Modulos "db" "Asg" no se le agrega la linea para asocirlos a un VPC, porque "db" y "asg" estan asociados a una subred 
# y esa subred ya esta previamente asociada a un VPC