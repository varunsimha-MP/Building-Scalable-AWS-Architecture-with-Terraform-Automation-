resource "aws_route53_record" "alb_dns" {
  zone_id = var.dns
  name = "simha.in.net"
  type = "A"
  alias {
    name = var.alb_dns_zone
    zone_id = var.alb_zone_id
    evaluate_target_health = true
  }
}