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
- module "db" → instancia RDS MySQL.

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

-Infraestructura modular.

-Separación de configuración y credenciales (archivos .tfvars y ~/.aws/credentials).

-Seguridad mediante SG

-Componentes críticos (EC2 y RDS) ubicados en subredes privadas.

-Uso de Launch Template en vez de Launch Configuration (deprecated)

-ALB + ASG para alta disponibilidad

-Documentación de módulos generada automáticamente con terraform-docs.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Monitoreo con Cloudwatch

Para mejorar la disponibilidad y la capacidad de respuesta de la aplicación, se integró Amazon CloudWatch con el Auto Scaling Group:

-Se creó un CloudWatch Log Group (/ecs/ecommerce-app) para centralizar logs de la aplicación.

-Se definió una política de escalado (scale-out-policy) asociada al ASG.

-Se configuró una alarma de CPU (asg-high-cpu) que monitorea el promedio de CPUUtilization de las instancias del Auto Scaling Group.

Comportamiento de la alarma

-Métrica: CPUUtilization (namespace AWS/EC2).

-Condición: si la CPU supera el umbral definido durante el período configurado,
la alarma pasa a estado ALARM y ejecuta la política de escalado.

-Acción: la política scale-out-policy incrementa la capacidad del ASG, agregando una nueva instancia EC2 para absorber la carga.

Esto permite:

-Escalar automáticamente cuando aumenta la carga sobre la aplicación.

-Mantener la disponibilidad ante picos de tráfico.

-Monitorear el estado del Auto Scaling Group desde la consola de CloudWatch (métricas y alarmas).