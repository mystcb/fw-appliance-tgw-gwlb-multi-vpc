# Route Table for the DMZ Subnets
resource "aws_route_table" "dmz_rt_a" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    "Name" = "DMZ_A_RT"
  }
}

resource "aws_route_table" "dmz_rt_b" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    "Name" = "DMZ_B_RT"
  }
}

# Route table entries for the subnets (A)
resource "aws_route" "dmz_a_gwlbe_route" {
  route_table_id         = aws_route_table.dmz_rt_a.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_a.id
  depends_on = [
    aws_route_table.dmz_rt_a,
    aws_vpc_endpoint.gwlb_endpoint_a
  ]
}

# TGW needs to be created before this is uncommented
resource "aws_route" "dmz_a_tgw_route" {
  route_table_id         = aws_route_table.dmz_rt_a.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgwa.transit_gateway_id
  depends_on = [
    aws_route_table.dmz_rt_a
  ]
}

# Route table entries for the subnets (B)
resource "aws_route" "dmz_b_gwlbe_route" {
  route_table_id         = aws_route_table.dmz_rt_b.id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb_endpoint_b.id
  depends_on = [
    aws_route_table.dmz_rt_b,
    aws_vpc_endpoint.gwlb_endpoint_b
  ]
}

# TGW needs to be created before this is uncommented
resource "aws_route" "dmz_b_tgw_route" {
  route_table_id         = aws_route_table.dmz_rt_b.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgwa.transit_gateway_id
  depends_on = [
    aws_route_table.dmz_rt_b
  ]
}