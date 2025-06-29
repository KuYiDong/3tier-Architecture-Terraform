output "web_alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.web_alb.arn
}

output "web_target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.web_tg.arn
}