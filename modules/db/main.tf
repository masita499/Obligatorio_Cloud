# llamado al recusro de grupo de subredes 
# esto define un objeto que tiene la facultad de agrupar dos, en este caso son subredes privadas, una en cada AZ.
resource "aws_db_subnet_group" "subnet_group_db" {
    subnet_ids             = var.private_subnets    # output del modulo networking, ahi se define esta agrupacion de subnets

}

# creacion de la base de datos, en github solamente estan las tablas, nosotros debemos crear la base de datos e importar esas tablas
resource "aws_db_instance" "instancia_db" {    # nombre del recurso en terraform
    identifier             = "db-obli"         # nombre del recurso en aws

    engine                 = "mysql"           # el motor que usara la db
    engine_version         = "8.0"             # la version del motor
    instance_class         = "db.t3.micro"     # en que clase hardware usara la db,
    allocated_storage      = 5                 # almacenamiento maximo en Gigabytes

                                               # se definen las credenciales que usara la db, todas sacadas del tfvars.
    db_name                = var.db_name       
    username               = var.db_username
    password               = var.db_password


    skip_final_snapshot     = true             # para facilitar el eliminado de la db, aws no tomara una snap y eso lo hace mas facil
    publicly_accessible    = false             # no sera accesible desde internet, lo ideal seria que solo la accedan las EC2
    multi_az               = true              # disponibilidad: la db esta asociada a las subnets y estas estan asociadas a AZs

    vpc_security_group_ids = [var.db_sg_id]    # habilita solo el trafico 3306 y lo ideal seria que lo haga desde las EC2
    db_subnet_group_name   = aws_db_subnet_group.subnet_group_db.name # la asociacion a las subnets que vimos al princio del codigo

}