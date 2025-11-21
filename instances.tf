# resource "aws_instance" "instancia_servidor_1" {
#   ami                    = var.ami
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.apps_sg.id]
#   subnet_id              = aws_subnet.private_subnet_1.id
#   key_name               = "terraform-key"
#   tags = {
#     Name      = "instancia_servidor_1"
#     terraform = "True"
#   }
# }

# resource "aws_instance" "instancia_servidor_2" {
#   ami                    = var.ami
#   instance_type          = "t2.micro"
#  # vpc_security_group_ids = [aws_security_group.ac1-sg.id]
#   subnet_id              = aws_subnet.private_subnet_2.id
#   key_name               = "terraform-key"
#   tags = {
#     Name      = "instancia_servidor_2"
#     terraform = "True"
#   }
# }

resource "aws_launch_template" "launch_template" {
  name_prefix   = "launch_template_OBLI"
  image_id      = var.ami
  instance_type = "t2.micro"
  #key_name      = "terraform-key"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = base64encode(<<-EOF
#!/bin/bash
yum update -y
yum install httpd git -y
systemctl enable httpd
systemctl start httpd
echo "Hola desde ASG - \$(hostname)" > /var/www/html/index.html
EOF
 )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "launch_template_OBLI"
    }
  }
}

resource "aws_autoscaling_group" "auto_scaling_group" {
  name                      = "auto_scaling_group_OBLI"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 60

  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  target_group_arns = [aws_lb_target_group.application_tg.arn]

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
