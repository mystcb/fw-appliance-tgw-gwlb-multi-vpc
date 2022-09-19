# The the creation of each subnet
resource "aws_subnet" "ngw_subnets" {
  count  = length(var.ngw_sn_ranges)
  vpc_id = aws_vpc.egress_vpc.id

  cidr_block        = element(concat(var.ngw_sn_ranges, [""]), count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name = "Egress-VPC-NATGW-Subnet-${count.index}"
  }
}