Obligatorio Cloud - Infraestructura en AWS usando terraform

Introduccion
Este proyecto implementa la creacion de la infraestrucutra necesaria para el despliege de un ecommerce php sobre aws academy utilizando terraform.
Se implementaron redes,balanceo de carga, escalado automatico, base de datos administrada y seguridad basada en modulos reutilizables.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

La arquitectura incluye:
- Una VPC con subredes públicas y privadas.
- Un Internet Gateway para salida a Internet.
- NAT Gateway para que las instancias privadas(instancias dentro del vpc) puedan actualizarse.
- Un Application Load Balancer (ALB) público.
- Auto Scaling Group (ASG) conectado al Target Group del ALB.
- Instancias EC2(desplegadas mediante el ASG) con Apache + PHP, configuradas con un Launch Template.
- Una base de datos MySQL en Amazon RDS.
- Security Groups para controlar el tráfico entre componentes.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Estructura del proyecto

Obligatorio_Cloud/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── networking/
│   ├── alb/
│   ├── security_groups/
│   ├── asg/
│   ├── db/
│
└── TERRAFORM_DOCS.md   # Documentación generada automáticamente con terraform docs

Cada modulos contiene 4 archivos 
-main.tf → contiene la creacion y configuracion de los recuros.
-outputs.tf → valores exportados para otros módulos
-variables.tf → variables del módulo
-Docs_"NombreModulo".md → contiene la documentacion del modulo echa con terraform docs

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Desarrolamos modulos especificos para esta pagina:

- module "vpc" → Crea la VPC
- module "networking" → IGW, NAT, route tables, subnets
- module "alb" → Application Load Balancer, Target Group, Listener
- module "security_groups" → SGs para ALB, EC2 y RDS
- module "asg" → Auto Scaling Group + Launch Template

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Despligue de la infraestructura

para un despliegue exitoso de la infraestructura es necesario agregar las credenciales para la base de datos en el archivo varibles.tfvars en la raiz (no son subidas con el archivo a git por cuestiones de seguridad), a su vez se deben agregar las credenciales de AWS en su respectiva carpeta .aws en el archivo "credentials".

Pasos para desplegar la Infraestructura

-Requisitos previos:
Terraform ≥ 1.6
Cuenta AWS Academy activa
Credenciales configuradas (credentials en .aws y credenciales de RDS)

-Inicializar Terraform
Terraform init

-Desplegar la infraestructura
terraform apply

-Terraform creará automáticamente toda la infraestructura.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Buenas Prácticas Implementadas

-Infraestructura modular

-Separación de configuración / credenciales

-Seguridad mediante SG

-Componentes en subredes privadas

-Uso de Launch Template en vez de Launch Configuration (deprecated)

-ALB + ASG para alta disponibilidad

-Documentación con terraform-docs