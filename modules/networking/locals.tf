locals {
    azs = data.aws_availability_zones.azs.names
    private_subnet_ids = aws_subnet.private_subnet.*.id
    pub_subnet_ids = aws_subnet.public_subnet.*.id
}
