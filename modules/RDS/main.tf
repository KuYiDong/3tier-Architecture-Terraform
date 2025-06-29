
locals {
  public_subnet_map = {
    for idx, id in var.database_subnets_ids:
    "web-${idx}" => id
  }

}

resource "aws_db_subnet_group" "subnet" {
    name = "my-db-subnet-group"
    subnet_ids = var.database_subnets_ids 

    tags = {
      Name = "My DB subnet group"
    }
}

resource "aws_db_instance" "multi_az" {
    identifier = "my-mariadb-multi-az"
    allocated_storage = 20
    storage_type = "standard"
    engine = "mysql"
    engine_version = "8.0.35"
    instance_class = "db.t3.small"
    username = "admin"
    password = "awsaws123"
    db_subnet_group_name = aws_db_subnet_group.subnet.name
    multi_az = true
    publicly_accessible = false
    skip_final_snapshot = true
    backup_retention_period = 7
    vpc_security_group_ids = [var.db_sg_id]

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }

  tags = {
    Name        = "multi-az-mariadb"
    Environment = "dev"
    }

}