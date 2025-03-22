#Creating app_VPC and its subnet, route table

resource "aws_vpc" "app_vpc" {
    cidr_block = var.vpc_cidr_1
    instance_tenancy = "default"
    enable_dns_hostnames = true 
    enable_dns_support = true 
    tags = var.vpc_tags_1 
}

resource "aws_internet_gateway" "main_internet_gateway" {
    vpc_id = aws_vpc.app_vpc.id  
    tags = var.IG_tags
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.app_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_internet_gateway.id
    }
    route {
        cidr_block = aws_vpc.db_vpc.cidr_block
        vpc_peering_connection_id = aws_vpc_peering_connection.peering_app_db.id
    }
    tags = var.public_route_table_tags
}


resource "aws_subnet" "public_subnet" {
    count = var.subnet_count
    vpc_id = aws_vpc.app_vpc.id
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

#Creating DB_VPC and its subnet, route table
resource "aws_vpc" "db_vpc" {
    cidr_block = var.vpc_cidr_2
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"
    tags = var.vpc_tags_2
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.db_vpc.id
    route {
        cidr_block = aws_vpc.app_vpc.cidr_block
        vpc_peering_connection_id = aws_vpc_peering_connection.peering_app_db.id
    }
    tags = var.private_route_table_tags  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.db_vpc.id
    count = var.subnet_count
    availability_zone = local.azs[count.index]
    cidr_block = var.private_subnet_cidr[count.index]
    tags = var.private_subnet_tags
}

resource "aws_route_table_association" "private_rt_associate" {
    count = var.subnet_count
    subnet_id = aws_subnet.private_subnet.*.id[count.index]
    route_table_id = aws_route_table.private_route_table.id
}
