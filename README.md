***

# 🌩️ Obligatorio Cloud – Infraestructura en AWS usando Terraform

Este proyecto implementa la creación de toda la infraestructura necesaria para desplegar un ecommerce en PHP sobre AWS Academy, utilizando Terraform y una arquitectura modular.
Incluye redes, balanceo de carga, alta disponibilidad, base de datos administrada y seguridad por capas.
***

# 🏗️ Arquitectura Implementada

VPC con subredes públicas y privadas

Internet Gateway para salida a internet

NAT Gateway para que las instancias privadas puedan actualizarse

Application Load Balancer (ALB) público

Auto Scaling Group (ASG) conectado al Target Group del ALB

Instancias EC2 (vía ASG) con Apache + PHP mediante Launch Template

Base de datos MySQL en Amazon RDS

Security Groups con tráfico segmentado entre componentes
***

# 📁 Estructura del Proyecto

```

Obligatorio_Cloud/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── Docs_vpc.md
│   ├── networking/
│   ├── alb/
│   ├── security_groups/
│   ├── asg/
│   └── db/
│
└── TERRAFORM_DOCS.md

```
***

# Cada módulo contiene:

```
main.tf → creación y configuración

outputs.tf → valores exportados

variables.tf → variables del módulo

Docs_<NombreModulo>.md → documentación generada con terraform-docs
```
***

# 🧩 Módulos desarrollados

```
module "vpc" → Crea la VPC

module "networking" → Crea IGW, NAT, route tables y subnets

module "alb" → Crea Application Load Balancer + Target Group + Listener

module "security_groups" Crea → SG del ALB, EC2 y RDS

module "asg" Crea  → Auto Scaling Group + Launch Template

module "db" Crea → Instancia RDS MySQL
```
***

# 🚀 Despliegue de la infraestructura

Para desplegar correctamente la infraestructura:

```
📌 Debés agregar las credenciales de la base de datos en terraform.tfvars (NO subidas al repositorio)
📌 Configurar las credenciales de AWS en ~/.aws/credentials
```
Requisitos previos

```
📌 Terraform ≥ 1.6

📌 Cuenta activa de AWS Academy

📌 Credenciales configuradas correctamente

📌Inicializar Terraform
    terraform init

📌Aplicar la infraestructura
    terraform apply

Terraform generará automáticamente todos los recursos.
```
***

# 🛡️ Buenas prácticas implementadas

Infraestructura 100% Modificable

Separación total entre configuración y credenciales

Security Groups específicos por componente

EC2 y RDS en subredes privadas

Alta disponibilidad mediante ALB + ASG

Documentación generada con terraform-docs

***

# 📊 Monitoreo con CloudWatch

## Para mejorar la disponibilidad del ecommerce se integró Amazon CloudWatch al Auto Scaling Group.

Recursos creados:

```
Log Group: /ecs/ecommerce-app

Política de escalado: scale-out-policy

Alarma de CPU: asg-high-cpu
```
***

# 🧠 Funcionamiento de la alarma

```
Métrica: CPUUtilization (AWS/EC2)

Condición: si la CPU supera el umbral → estado ALARM

Acción: ejecuta scale-out-policy, agregando una instancia EC2
```
***

## Esto permite:
```
Escalado automático ante picos de tráfico

Alta disponibilidad constante

Monitoreo completo desde la consola de CloudWatch
```
***