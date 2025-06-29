output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.multi_az.endpoint
}

output "rds_port" {
  description = "The port the RDS instance listens on"
  value       = aws_db_instance.multi_az.port
}
