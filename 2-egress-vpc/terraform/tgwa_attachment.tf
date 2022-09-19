# Attachment of the Transit Gateway to the VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "tgwa" {
  subnet_ids         = aws_subnet.tgwa_subnets.*.id
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  vpc_id             = aws_vpc.egress_vpc.id
}