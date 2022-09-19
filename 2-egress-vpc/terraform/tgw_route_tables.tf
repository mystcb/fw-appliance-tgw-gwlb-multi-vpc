# Transit Gateway Route table for the Spoke VPC's in other accounts enabling
# External Internet Access through the Checkpoint Firewalls
resource "aws_ec2_transit_gateway_route_table" "spoke_vpc_tgw_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  tags = {
    "Name" = "Spoke VPC Transit Gateway RT"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_attach" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgwa.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke_vpc_tgw_rt.id
}