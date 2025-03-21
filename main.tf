module "test_vpc" {
  source = "./modules/networking"
}

module "test_rds" {
  source  = "./modules/rds"
  sub_ids = module.test_vpc.pri_subnet_ids
  vpc_id  = module.test_vpc.vpc_id
  rds_ingress_rule = {
    "3306" = {
      port        = 3306
      protocol    = "tcp"
      cidr_blocks = []
      description = "allow RDS access"
      security_group = [module.test_instance.security_group]
    }
  }
}

module "test_instance" {
  source    = "./modules/ec2"
  key       ="mum_private_key"
  subnet_id = module.test_vpc.pub_subnet_ids
  vpc_id    = module.test_vpc.vpc_id
  web_ingress_rule = {
    "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow HTTP access"
    }
    "22" = {
      port        = 22
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow SSH access"
    }
    "icmp" = {
      port        = 0
      protocol    = "-1"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow ping access"
    }
  }
}

module "test_alb" {
    source = "./modules/ALB" 
    vpc_id = module.test_vpc.vpc_id
    subnet_ids = module.test_vpc.pub_subnet_ids
    alb_ingress_rule = {
      "80" = {
      port        = 80
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow HTTP access"
      }
    }
    instance = module.test_instance.instance_id
}