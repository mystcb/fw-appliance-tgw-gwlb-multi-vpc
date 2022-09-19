# Route Table for the Firewall Appliance Subnets
resource "aws_route_table" "fwa_rt" {
  count  = length(var.fwa_sn_ranges)
  vpc_id = aws_vpc.egress_vpc.id

  tags = {
    "Name" = "Firewall Appliance Route Table ${count.index}"
  }
}

# Route to the NAT Gateway per subnet
resource "aws_route" "fwa2natgw" {
  count                  = length(var.fwa_sn_ranges)
  route_table_id         = aws_route_table.fwa_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[count.index].id
}

# Route to the Transit Gateway for all local subnets
resource "aws_route" "fwa2tgw" {
  count                  = length(var.fwa_sn_ranges)
  route_table_id         = aws_route_table.fwa_rt[count.index].id
  destination_cidr_block = var.aws_cidrs
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgwa.transit_gateway_id
}

# Attach the route table to the subnet
resource "aws_route_table_association" "fwa" {
  count          = length(var.fwa_sn_ranges)
  subnet_id      = aws_subnet.fwa_subnets[count.index].id
  route_table_id = aws_route_table.fwa_rt[count.index].id
}