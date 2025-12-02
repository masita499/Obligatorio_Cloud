##creacion del launch template 
resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template_OBLI_V2"
  image_id      = var.ami
  instance_type = var.instance_type
  #key_name      = "terraform-key"

  vpc_security_group_ids = [var.app_sg_id]

##el user data aprovisiona las instancias que se instalaran mediante el asg con todo lo necesario para un despliege exitoso
  user_data = base64encode(<<-EOF
#!/bin/bash
set -xe

yum update -y
yum install -y docker git mariadb || dnf install -y docker git mariadb

systemctl enable docker
systemctl start docker

mkdir -p /opt/app
cd /opt/app
git clone https://github.com/masita499/Pagina_Docker_Obligatorio.git app
cd app

mysql -h "${var.db_endpoint}" -u "${var.db_username}" -p"${var.db_password}" \
  -e "CREATE DATABASE IF NOT EXISTS ${var.db_name} CHARACTER SET latin1;"

mysql -h "${var.db_endpoint}" -u "${var.db_username}" -p"${var.db_password}" \
  "${var.db_name}" < db-settings.sql || echo "BD posiblemente ya inicializada, continuando..."


cat > Dockerfile << 'DOCKEREOF'

FROM php:8.2-apache
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    docker-php-ext-install pdo_mysql

RUN a2enmod rewrite && \
    sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf && \
    printf "\n<Directory /var/www/html>\n    AllowOverride All\n</Directory>\n" > /etc/apache2/conf-enabled/override.conf

WORKDIR /var/www/html
COPY . /var/www/html
DOCKEREOF

docker build -t ecommerce-php .

docker run -d --name ecommerce-container \
  -e DB_HOST="${var.db_endpoint}" \
  -e DB_NAME="${var.db_name}" \
  -e DB_USER="${var.db_username}" \
  -e DB_PASS="${var.db_password}" \
  -p 80:80 \
  ecommerce-php

EOF
)


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "launch_template_OBLI"
    }
  }
}

##creacion del auto scaling group 
resource "aws_autoscaling_group" "auto_scaling_group" {
  name                      = "auto_scaling_group_OBLI"
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300

  vpc_zone_identifier = var.private_subnets

  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "app_asg_instance_OBLI"
    propagate_at_launch = true
  }
}

