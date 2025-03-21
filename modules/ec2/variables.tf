variable "instance_ami" {
    default = "ami-00bb6a80f01f03502"
}

variable "public_id" {
  default = true
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_id" {  
}

variable "ec2_name" {
    default = {
        Name = "test_instance"
    }
}

variable "vpc_id" {
}


variable "sg"{
    default = {
        Name ="sg"
    }
}

variable "web_ingress_rule" {
    type = map(object({
        port = number
        protocol = string
        cidr_block = list(string)
        description = string
    }))
}

variable "key" {
}