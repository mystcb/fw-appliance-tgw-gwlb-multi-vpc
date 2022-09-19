# Route Table for the Checkpoint Subnets
resource "aws_route_table" "tgwa_rt" {
  count  = length(var.tgwa_sn_ranges)
  vpc_id = aws_vpc.egress_vpc.id

  tags = {
    "Name" = "TGW Attachmet Route Table ${count.index}"
  }
}

# Route all traffic to the GWLB Endpoints
resource "aws_route" "all2gwlbe" {
  count                  = length(var.tgwa_sn_ranges)
  route_table_id         = aws_route_table.tgwa_rt[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = aws_vpc_endpoint.gwlb[count.index].id
}

# Attach the route table to the subnet
resource "aws_route_table_association" "tgwa" {
  count          = length(var.tgwa_sn_ranges)
  subnet_id      = aws_subnet.tgwa_subnets[count.index].id
  route_table_id = aws_route_table.tgwa_rt[count.index].id
}