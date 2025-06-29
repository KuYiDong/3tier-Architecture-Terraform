variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "ext_alb_sg_id" {
    type = string
}

variable "acm_certificate_arn" {
    description = "ACM Certificate ARN for ALB listener"
    type      = string
    default   = "arn:aws:acm:ap-northeast-2:897722700830:certificate/04f03d10-83a2-4262-a1e6-5c59849c74c6"
}





