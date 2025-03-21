resource "aws_lb_target_group" "tg" {
    name =var.tg_name
    port = var.tg_port
    protocol = var.tg_portocol
    vpc_id = var.vpc_id
}


resource "aws_lb" "main_lb" {
    name = "alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = var.subnet_ids
}

resource "aws_security_group" "alb_sg" {
    name = var.alb_name
    description = "alb"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.alb_ingress_rule
        content {
          description = "inbound rule"
          from_port = ingress.value.port
          to_port = ingress.value.port
          protocol = ingress.value.protocol
          cidr_blocks = ingress.value.cidr_block
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }
    tags = var.alb_sg
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count = length(var.instance)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = var.instance[count.index]
}