output "asg_name" {
  description = "Name of Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.name
}
