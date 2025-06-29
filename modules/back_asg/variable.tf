variable "ami" {
    type = string
    default = "ami-0f605570d05d73472"
}


variable "was_sg_id" {
    type = string
}

variable "type" {
    default = "t2.micro"
    type = string

}

variable "was_subnet_ids" {
    type = list(string)
}

variable "was_alb_target_arn" {
    type = string
}