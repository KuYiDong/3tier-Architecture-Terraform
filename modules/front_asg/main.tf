locals {
  public_subnet_map = {
    for idx, id in var.web_subnet_ids:
    "web-${idx}" => id
  }

}

resource "aws_launch_template" "Web_lt" {
    name_prefix = "web_lt"
    image_id = var.ami
    instance_type = var.type
    key_name = "my-key-pair"

    vpc_security_group_ids = [ var.web_sg_id ]

    user_data =  base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo yum install -y git

              sudo systemctl enable --now httpd

              sudo git clone https://github.com/KuYiDong/WebHtml.git
              sudo cp WebHtml/index.html /var/www/html/
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

resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = var.web_subnet_ids
  target_group_arns         = [var.web_alb_target_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.Web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "WebASGInstance"
    propagate_at_launch = true
  }
}


