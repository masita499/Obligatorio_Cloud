# creacion del vpc donde contendra todos los componentes de la infraestructura aws

resource "aws_vpc" "vpc" {
    cidr_block =var.vpc_cidr       # contenido del tfvars
    enable_dns_support   = true    # habilita el dns dentro del vpc, sin esto no andaria ni la verificacion de la web en las ec2
                                   # ni la coneccion entre la ec2 y la base de datos
    enable_dns_hostnames = true    # habilita la implementacion de registros dns 

  tags = {
    Name = var.vpc_name           # nombre amigable del recurso creado en aws
  }
}