output "aws_route53_record_servername" {
    value = aws_route53_zone.dns.name_servers  
}

output "route" {
  value = aws_route53_zone.dns
}

output "acm_certificate" {
    value = aws_acm_certificate.ssl.arn
  
}

output "dns" {
  value = aws_route53_zone.dns.zone_id
}