variable "vpc_id" {  
}

variable "alb_sg" {
  default = {
    Name = "alb_sg"
  }
}

variable "tg_name" {
    default = "tg"
}


variable "tg_port" {
  default = "80"
}

variable "tg_portocol" {
    default = "HTTP"
}

variable "alb_name" {
    default = "alb_name"
}

variable "subnet_ids" {
      
}

variable "alb_ingress_rule" {
    type = map(object({
        port = number
        protocol = string
        cidr_block = list(string)
        description = string
    }))
}

variable "alb_egress_rule" {
    type = map(object({
        port = number
        protocol = string
        cidr_block = list(string)
        description = string
    }))
}

variable "instance" {
  type = list(string)
  default = [ ]
}

variable "route" {
  
}

variable "sl_valid_alb" {
  
}