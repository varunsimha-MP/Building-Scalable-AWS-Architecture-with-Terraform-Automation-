variable "rds" {
    default = {
        Name = "rds"
    }
}

variable "sub_ids" {
}

variable "storage" {
    default = 10  
}

variable "db_name" {
    default = "mydb"
}

variable "username" {
    default = "admin"
}

variable "password" {
    default = "Simha!0987"
}

variable "vpc_id" {
}

variable "sg"{
    default = {
        Name ="sg"
    }
}

variable "rds_ingress_rule" {
    type = map(object({
        port = number
        protocol = string
        cidr_blocks= list(string)
        description = string
        security_group = list(string)
    }))
}