resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template_OBLI_V2"
  image_id      = var.ami
  instance_type = var.instance_type
  #key_name      = "terraform-key"

  vpc_security_group_ids = [var.app_sg_id]

  user_data = base64encode(<<-EOF
#!/bin/bash

yum update -y

yum install  docker git -y
systemctl enable docker
systemctl start docker

mkdir -p /opt/app
cd /opt/app
git clone https://github.com/masita499/Pagina_Docker_Obligatorio.git app
cd app

mysql -h "${var.db_endpoint}" -u "${var.db_username}" -p"${var.db_password}" ${var.db_name} < db-settings.sql

cat > Dockerfile << 'DOCKEREOF'
FROM php:8.2-apache
RUN a2enmod rewrite 
RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN docker-php-ext-install pdo pdo_mysql
COPY . /var/www/html
WORKDIR /var/www/html
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

##docker run -d --name ecommerce-container -p 80:80 ecommerce-php

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "launch_template_OBLI"
    }
  }
}

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
