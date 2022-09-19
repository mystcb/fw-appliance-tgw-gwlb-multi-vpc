#
# Example for a North Virginia Office VPN connection, connected to the North Virginia Region
#

# Customer Gateway for the S2S VPN, note the separate BGP ASN
resource "aws_customer_gateway" "use_office" {
  bgp_asn    = var.use_office_asn
  ip_address = var.use_cgw
  type       = "ipsec.1"
  provider   = aws.us-east

  tags = {
    "Name" = "North-Virginia-Office-CGW"
  }

}

# Site to Site VPN connection connected to the Transit Gatway in North Virginia
resource "aws_vpn_connection" "use_office" {
  customer_gateway_id = aws_customer_gateway.use_office.id
  transit_gateway_id  = aws_ec2_transit_gateway.use.id
  type                = aws_customer_gateway.use_office.type
  provider            = aws.us-east

  tags = {
    "Name" = "North-Virginia Office S2S VPN"
  }
}