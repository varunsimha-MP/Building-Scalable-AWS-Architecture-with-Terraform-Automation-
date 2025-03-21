resource "aws_db_subnet_group" "rds_subnet" {
    name = "rds_subnet"
    subnet_ids = var.sub_ids
    tags = var.rds
}


resource "aws_db_instance" "rds" {
    allocated_storage = var.storage
    db_name = var.db_name
    engine = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = var.username
    password             = var.password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    db_subnet_group_name = aws_db_subnet_group.rds_subnet.name 
    vpc_security_group_ids = [aws_security_group.rds_SG.id]
}

resource "aws_security_group" "rds_SG" {
    name = "RDS_SG"
    description = "rds_sg"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.rds_ingress_rule
        content {
          description = "inbound rule"
          from_port = ingress.value.port
          to_port = ingress.value.port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_blocks
          security_groups = ingress.value.security_group
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }
    tags = var.sg
}