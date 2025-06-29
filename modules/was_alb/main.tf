locals {
  public_subnet_map = {
    for idx, id in var.was_subnet_ids :
    "was-${idx}" => id
  }

}

resource "aws_lb" "was_alb" {
  name = "was-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = [var.int_alb_sg_id]
  subnets = var.was_subnet_ids
  enable_deletion_protection = false
}


resource "aws_lb_target_group" "was_tg" {
    name = "was-tg"
    port = 8080
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      protocol = "HTTP"
      path = "/health"
      port = "8080"
    }
}


resource "aws_lb_listener" "web_https_listener" {
  load_balancer_arn = aws_lb.was_alb.arn
  port              = 8080
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.was_tg.arn
  }
}



