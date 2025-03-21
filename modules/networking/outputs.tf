output "pri_subnet_ids" {
    value = local.private_subnet_ids
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "pub_subnet_ids" {
  value = local.pub_subnet_ids
}
