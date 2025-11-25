resource "aws_db_subnet_group" "subnet_group_db" {
    subnet_ids             = var.private_subnets

}

resource "aws_db_instance" "instancia_db" {
    identifier             = "db-obli"

    engine                 = "mysql" 
    engine_version         = "8.0"
    instance_class         = "db.t3.micro"
    allocated_storage      = 5

    db_name                = var.db_name
    username               = var.db_username
    password               = var.db_password


    skip_final_snapshot     = true
    publicly_accessible    = false
    multi_az               = true

    vpc_security_group_ids = [var.db_sg_id]
    db_subnet_group_name   = aws_db_subnet_group.subnet_group_db.name

}