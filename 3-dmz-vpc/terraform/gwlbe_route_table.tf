# Route Table for the GWLBSubnets
resource "aws_route_table" "gwlbe_rt" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    "Name" = "GWLBe_RT"
  }
}

resource "aws_route" "gwlbep_igw_route" {
  route_table_id         = aws_route_table.gwlbe_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
  depends_on = [
    aws_route_table.gwlbe_rt,
    aws_internet_gateway.gw
  ]
}

# Associate the route table with the IGW
resource "aws_route_table_association" "gwlbe_rta" {
  subnet_id      = aws_subnet.gwlbe_subnets[0].id
  route_table_id = aws_route_table.gwlbe_rt.id
}

resource "aws_route_table_association" "gwlbe_rtb" {
  subnet_id      = aws_subnet.gwlbe_subnets[1].id
  route_table_id = aws_route_table.gwlbe_rt.id
}