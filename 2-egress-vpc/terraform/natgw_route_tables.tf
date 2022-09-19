# Route Table for the NAT Gateway Subnets
resource "aws_route_table" "ngw_rt" {
  count  = length(var.ngw_sn_ranges)
  vpc_id = aws_vpc.egress_vpc.id

  tags = {
    "Name" = "NATGW Route Table ${count.index}"
  }
}

# Route to the IGW
resource "aws_route" "natgw2igw" {
  count                  = length(var.ngw_sn_ranges)
  route_table_id         = aws_route_table.ngw_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Route to the Gateway Load Balancer Endpoint for Internal Services
resource "aws_route" "natgw2gwlbe" {
  count                  = length(var.ngw_sn_ranges)
  route_table_id         = aws_route_table.ngw_rt[count.index].id
  destination_cidr_block = var.aws_cidrs
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb[count.index].id
}

# Attach the route table to the subnet
resource "aws_route_table_association" "natgw" {
  count          = length(var.ngw_sn_ranges)
  subnet_id      = aws_subnet.ngw_subnets[count.index].id
  route_table_id = aws_route_table.ngw_rt[count.index].id
}