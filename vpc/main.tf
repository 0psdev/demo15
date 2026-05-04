//VPC
resource "aws_vpc" "vpc_demo" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Project = "demo"
        Type = "vpc"
        Desc = "vpc"
    }
}
//Public Subnet
resource "aws_subnet" "pubsub_demo" {
    for_each = toset(var.pubnet_names)
    vpc_id = aws_vpc.vpc_demo.id
    cidr_block = var.pubnet_specs[each.key].cidr_block
    availability_zone = var.pubnet_specs[each.key].availability_zone
    map_public_ip_on_launch = true
    tags = {
        Project = "demo"
        Type = "subnet"
        Az = var.pubnet_specs[each.key].az
        Desc = var.pubnet_specs[each.key].desc
    }
  
}
//Private Subnet
resource "aws_subnet" "prisub_demo" {
    for_each = toset(var.prinet_names)
    vpc_id = aws_vpc.vpc_demo.id
    cidr_block = var.prinet_specs[each.key].cidr_block
    availability_zone = var.prinet_specs[each.key].availability_zone
    tags = {
        Project = "demo"
        Type = "subnet"
        Az = var.prinet_specs[each.key].az
        Desc = var.prinet_specs[each.key].desc
    }
  
}

