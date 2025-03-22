module "test_vpc" {
  source = "./modules/networking"
}

module "test_rds" {
  source  = "./modules/rds"
  sub_ids = module.test_vpc.pri_subnet_ids
  vpc_id  = module.test_vpc.db_vpc_id
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
  vpc_id    = module.test_vpc.app_vpc_id
  web_ingress_rule = {
    "80" = {
      port        = 443
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

module "test_dns" {
  source = "./modules/dns"
}

module "test_alb" {
    source = "./modules/ALB" 
    vpc_id = module.test_vpc.app_vpc_id
    subnet_ids = module.test_vpc.pub_subnet_ids
    route = module.test_dns.route
    sl_valid_alb = module.test_dns.acm_certificate
    alb_ingress_rule = {
      "HTTPS" = {
      port        = 443
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow HTTP access"
      }
      "HTTP" = {
      port        = 80
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "allow HTTP access"
      }
    }
    alb_egress_rule = {
      "EC2_map" = {
        port = 80
        protocol = "tcp"
        cidr_block = []
        security_group = [module.test_instance.security_group]
        description = "Outbounding to ec2 sg"
      }
    }
    instance = module.test_instance.instance_id
}

module "test_configure_alb_to_route53" {
  source = "./modules/configure_alb_to_route53"
  alb_dns_zone  = module.test_alb.alb_dns_zone
  alb_zone_id   = module.test_alb.alb_zone_id
  dns = module.test_dns.dns
}