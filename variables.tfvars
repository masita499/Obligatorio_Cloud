# 1- El unico proposito del contenido de este archivo es harcodear los valores de las variables. 
# 2- No es buena practica hardcodear el contenido de las variables sensibles asociado a credenciales.
# 3- En caso de no ponerlos, el automatismo se corta porque no se le brinda los recursos necesarios para que pueda ser un despliegue
# automatico
#----------------------------------------------------------------------------------------------------------------
# 4- Dado a que esto se tiene que documentar y subir a git, se lo expone a que cualquiera vea las credenciales.
#  4.1 Lo que se sube a Git: No se muestra credenciales
#  4.2 Lo que NO SE SUBE a GIT: Se deja las credenciales harcodeadas.
#----------------------------------------------------------------------------------------------------------------

perfil = "default"

ami = "ami-0c2b8ca1dad447f8a"

instance_type = "t2.micro"

region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

private_subnet_1 = "10.0.1.0/24"

private_subnet_2 = "10.0.2.0/24" 

public_subnet_1 = "10.0.10.0/24"

public_subnet_2 = "10.0.20.0/24"

min_size = 2 

max_size = 4
 
desired_capacity = 2

vpc_aws_az_1 = "us-east-1a"

vpc_aws_az_2 = "us-east-1b"




# Informacion Base de datos: (4.2) DATOS SENSIBLES.
db_name     = ""
db_username = ""
db_password = ""

