# The the creation of each subnet
resource "aws_subnet" "fwa_subnets" {
  count  = length(var.fwa_sn_ranges)
  vpc_id = aws_vpc.egress_vpc.id

  cidr_block        = element(concat(var.fwa_sn_ranges, [""]), count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name = "Egress-VPC-Firewall-Appliance-Subnet-${count.index}"
  }

  depends_on = [
    aws_subnet.tgwa_subnets
  ]
}