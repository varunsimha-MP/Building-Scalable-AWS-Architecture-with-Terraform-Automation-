output "alb" {
  value = aws_lb.main_lb
}

output "alb_dns_zone" {
  value = aws_lb.main_lb.dns_name
}

output "alb_zone_id" {
    value = aws_lb.main_lb.zone_id
}