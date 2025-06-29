module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs               = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]              # ALB, NAT GW
  private_subnets   = ["10.0.10.0/24", "10.0.20.0/24",            # Web Tier
                       "10.0.30.0/24", "10.0.40.0/24"]            # App Tier
  database_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]          # DB Tier

  enable_nat_gateway       = true
  one_nat_gateway_per_az   = false
  enable_vpn_gateway       = true
  enable_dns_support       = true
  enable_dns_hostnames     = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# 서브넷 역할 분리
locals {
  web_subnet_ids = slice(module.vpc.private_subnets, 0, 2)  
  was_subnet_ids = slice(module.vpc.private_subnets, 2, 4)  # 10.0.30.0/24, 10.0.40.0/24
}

module "sg" {
  source = "../../modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "web_alb" {
  source            = "../../modules/web_alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  
  ext_alb_sg_id     = module.sg.ext_alb_sg_id
}

module "was_alb" {
  source             = "../../modules/was_alb"
  vpc_id             = module.vpc.vpc_id
  was_subnet_ids     = local.was_subnet_ids  
  int_alb_sg_id      = module.sg.int_alb_sg_id
}

module "front_asg" {
  source               = "../../modules/front_asg"
  web_subnet_ids    = local.web_subnet_ids   
  web_sg_id            = module.sg.web_sg_id
  web_alb_target_arn   = module.web_alb.web_target_group_arn
  depends_on           = [module.web_alb]
}

module "back_asg" {
  source               = "../../modules/back_asg"
  was_subnet_ids       = local.was_subnet_ids   
  was_sg_id            = module.sg.was_sg_id
  was_alb_target_arn   = module.was_alb.was_alb_target_arn
  depends_on           = [module.was_alb]
}

module "database" {
  source                = "../../modules/RDS"
  database_subnets_ids  = module.vpc.database_subnets
  db_sg_id              = module.sg.db_sg_id
}