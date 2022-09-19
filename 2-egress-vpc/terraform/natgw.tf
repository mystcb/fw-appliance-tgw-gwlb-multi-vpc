# Elastic IP's for the NAT Gateways
resource "aws_eip" "natgw_ip" {
  count = length(var.ngw_sn_ranges)
  vpc   = true
}

resource "aws_nat_gateway" "ngw" {
  count         = length(var.ngw_sn_ranges)
  allocation_id = aws_eip.natgw_ip[count.index].id
  subnet_id     = aws_subnet.ngw_subnets[count.index].id

  tags = {
    "Name" = "NATGW for Subnet ${count.index}"
  }

  depends_on = [
    aws_internet_gateway.gw
  ]
}