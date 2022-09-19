# The the creation of each subnet
resource "aws_subnet" "gwlbe_subnets" {
  count  = length(var.gwlbe_sn_ranges)
  vpc_id = aws_vpc.dmz_vpc.id

  cidr_block        = element(concat(var.gwlbe_sn_ranges, [""]), count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name = "gwlbe_sn_${count.index}"
  }
}