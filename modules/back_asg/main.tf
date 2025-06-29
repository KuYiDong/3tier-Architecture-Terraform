locals {
  private_subnet_map = {
    for idx, id in var.was_subnet_ids :
    "was-${idx}" => id
  }
}

resource "aws_launch_template" "was_lt" {
    name_prefix = "was_lt"
    image_id = var.ami
    instance_type = var.type
    key_name = "my-key-pair"

    vpc_security_group_ids = [ var.was_sg_id ]

    user_data =  base64encode(<<-EOF
            #!/bin/bash
            sudo yum update -y

            sudo yum install -y httpd
            sudo systemctl enable httpd
            sudo systemctl start httpd

            echo "OK" | sudo tee /var/www/html/health

            # httpd 포트 변경 (기본 80 → 8080 으로 바꾸기)
            sudo sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
            sudo systemctl restart httpd

            EOF
  )
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Webinstance"
    }
  }
  tag_specifications {
  resource_type = "volume"
  tags = {
    Name = "Webinstance-volume"
    } 
  }
}

resource "aws_autoscaling_group" "was_asg" {
  name                      = "was-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = var.was_subnet_ids
  target_group_arns         = [var.was_alb_target_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.was_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "WasASGInstance"
    propagate_at_launch = true
  }
}


