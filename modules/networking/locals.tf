locals {
    azs = data.aws_availability_zones.azs.names
    private_subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id ]
    pub_subnet_ids = [for subnet in aws_subnet.public_subnet : subnet.id ]
}
