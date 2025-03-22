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
    dynamic "egress" {
        for_each = var.alb_egress_rule
        content {
          description = "Outbound_rule"
          from_port = egress.value.port
          to_port = egress.value.port
          protocol = egress.value.protocol
          cidr_blocks = egress.value.cidr_block
        }
    }
    tags = var.alb_sg
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count = length(var.instance)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = var.instance[count.index]
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.sl_valid_alb
  default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
  depends_on = [ var.route ]
  }

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      protocol = "HTTPS"
      port = 443
    }
  }
}


