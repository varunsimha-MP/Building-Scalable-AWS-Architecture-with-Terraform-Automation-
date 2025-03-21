variable "vpc_cidr" {
    default = "10.20.0.0/16"
}

variable "vpc_tags" {
    default = {
        Name = "app-vpc"
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

variable "private_tags" {
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
    default = ["10.20.2.0/24","10.20.4.0/24"]
}