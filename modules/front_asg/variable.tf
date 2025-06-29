variable "ami" {
    type = string
    default = "ami-0f605570d05d73472"
}


variable "web_sg_id" {
    type = string
}

variable "type" {
    default = "t2.micro"
    type = string

}

variable "web_subnet_ids" {
    type = list(string)
}

variable "web_alb_target_arn" {
    type = string
}