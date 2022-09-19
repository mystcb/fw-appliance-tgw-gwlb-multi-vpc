# Route table for the Internet Gateway
resource "aws_route_table" "igw_rt" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    Name = "IGW_RT"
  }
}

resource "aws_route" "gwlbe_route_a" {
  route_table_id         = aws_route_table.igw_rt.id
  destination_cidr_block = aws_subnet.gwlbe_subnets[0].cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_a.id
  depends_on = [
    aws_route_table.igw_rt,
    aws_vpc_endpoint.gwlb_endpoint_a
  ]
}

resource "aws_route" "gwlbe_route_b" {
  route_table_id         = aws_route_table.igw_rt.id
  destination_cidr_block = aws_subnet.gwlbe_subnets[1].cidr_block
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_b.id
  depends_on = [
    aws_route_table.igw_rt,
    aws_vpc_endpoint.gwlb_endpoint_b
  ]
}

# Associate the route table with the IGW
resource "aws_route_table_association" "igw_rta" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.igw_rt.id
}