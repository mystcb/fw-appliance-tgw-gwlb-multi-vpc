# Main VPC block
resource "aws_vpc" "egress_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = var.vpc_name
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.egress_vpc.id
}