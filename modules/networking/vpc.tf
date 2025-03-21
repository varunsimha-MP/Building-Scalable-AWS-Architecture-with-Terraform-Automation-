resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    tags = var.vpc_tags  
}

resource "aws_internet_gateway" "main_internet_gateway" {
    vpc_id = aws_vpc.main_vpc.id  
    tags = var.IG_tags
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_internet_gateway.id
    }
    tags = var.public_route_table_tags
}


resource "aws_subnet" "public_subnet" {
    count = var.subnet_count
    vpc_id = aws_vpc.main_vpc.id
    availability_zone = local.azs[count.index]
    cidr_block = var.pub_subnet_cidr[count.index]
    map_public_ip_on_launch = true
    tags = var.public_tags
}

resource "aws_route_table_association" "public" {
    count = var.subnet_count
    subnet_id = aws_subnet.public_subnet.*.id[count.index]
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "privte_route_table" {
    vpc_id = aws_vpc.main_vpc.id
    tags = var.private_route_table_tags
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    count = var.subnet_count
    availability_zone = local.azs[count.index]
    cidr_block = var.private_subnet_cidr[count.index]
    tags = var.private_tags  
}

resource "aws_route_table_association" "private" {
    count = var.subnet_count
    subnet_id = aws_subnet.private_subnet.*.id[count.index]
    route_table_id = aws_route_table.privte_route_table.id
}