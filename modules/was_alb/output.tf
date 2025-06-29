output "was_alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.was_alb.arn
}

output "was_alb_target_arn" {
  description = "Target Group ARN for WAS ALB"
  value       = aws_lb_target_group.was_tg.arn
}
