locals {
  public_subnet_map = {
    for idx, id in var.public_subnet_ids :
    "web-${idx}" => id
  }

}

resource "aws_lb" "web_alb" {
  name = "web-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.ext_alb_sg_id]
  subnets = var.public_subnet_ids

  enable_deletion_protection = false
  
}


resource "aws_lb_target_group" "web_tg" {
    name = "web-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      protocol = "HTTP"
      path = "/"
      port = "80"
    }
}



resource "aws_lb_listener" "web_https_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.acm_certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}