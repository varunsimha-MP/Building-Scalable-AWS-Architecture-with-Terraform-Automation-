variable "vpc_cidr_1" {
    default = "10.20.0.0/16"
}

variable "vpc_cidr_2" {
    default = "10.0.0.0/16"
}

variable "vpc_tags_1" {
    default = {
        Name = "app-vpc"
    }
}

variable "vpc_tags_2" {
    default = {
        Name = "db-vpc"
    }
}

variable "public_tags" {
    default = {
        Name = "Public_subnet"
    }
}

variable "public_route_table_tags" {
    default = {
        Name = "Public_route_table"
    }
}

variable "private_subnet_tags" {
    default = {
        Name = "private_subnet"
    }
}

variable "private_route_table_tags" {
    default = {
        Name = "private_route_table"
    }
}

variable "IG_tags" {
    default = {
        Name = "internet_gateway"
    }
}

variable "subnet_count" {
    default = 2  
}


variable "pub_subnet_cidr" {
    default = ["10.20.0.0/24","10.20.1.0/24"]
}

variable "private_subnet_cidr" {
    default = ["10.0.2.0/24","10.0.4.0/24"]
}

variable "peering" {
    default = "peering_from_app_to_db"
}

variable "peering_name" {
    default = {
        Name = "peering_from_app_to_db"
    }
}