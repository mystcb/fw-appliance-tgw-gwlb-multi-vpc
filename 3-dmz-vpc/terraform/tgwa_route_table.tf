# Route Table for the App Subnets
resource "aws_route_table" "tgwa_rt" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    "Name" = "TGWA_RT"
  }
}

# Attachment of the Transit Gateway to the VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "tgwa" {
  subnet_ids         = aws_subnet.tgwa_subnets.*.id
  transit_gateway_id = var.tgw_id
  vpc_id             = aws_vpc.dmz_vpc.id
}