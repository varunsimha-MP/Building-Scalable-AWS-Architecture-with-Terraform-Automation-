output "pri_subnet_ids" {
    value = local.private_subnet_ids
}

output "app_vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "db_vpc_id" {
  value = aws_vpc.db_vpc.id
}

output "pub_subnet_ids" {
  value = local.pub_subnet_ids
}
