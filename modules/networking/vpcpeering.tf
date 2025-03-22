resource "aws_vpc_peering_connection" "peering_app_db" {
    peer_vpc_id = aws_vpc.db_vpc.id
    vpc_id = aws_vpc.app_vpc.id
    auto_accept = true  
    accepter {
      allow_remote_vpc_dns_resolution = true 
    }
    requester {
      allow_remote_vpc_dns_resolution = true
    }
    tags = var.peering_name
}