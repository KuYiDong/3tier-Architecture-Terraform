output "bastion_sg_id" {
  description = "ID of bastion SG"
  value       = aws_security_group.bastion_host.id
}

output "ext_alb_sg_id" {
  description = "ID of ext alb SG"
  value       = aws_security_group.ext_alb_sg.id
}

output "web_sg_id" {
  description = "ID of web SG"
  value       = aws_security_group.web_sg.id
}

output "int_alb_sg_id" {
  description = "ID of int alb SG"
  value       = aws_security_group.int_alb_sg.id
}

output "was_sg_id" {
  description = "ID of was SG"
  value       = aws_security_group.was_sg.id
}

output "db_sg_id" {
  description = "ID of db SG"
  value       = aws_security_group.db_sg.id
}
