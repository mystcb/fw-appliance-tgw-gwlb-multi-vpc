#
# Example for a London Office VPN connection, connected to the London Region
#

# Customer Gateway for the S2S VPN, note the separate BGP ASN
resource "aws_customer_gateway" "ldn_office" {
  bgp_asn    = var.ldn_office_asn
  ip_address = var.ldn_cgw
  type       = "ipsec.1"

  tags = {
    "Name" = "London-Office-CGW"
  }

}

# Site to Site VPN connection connected to the Transit Gatway
resource "aws_vpn_connection" "ldn_office" {
  customer_gateway_id = aws_customer_gateway.ldn_office.id
  transit_gateway_id  = aws_ec2_transit_gateway.ldn.id
  type                = aws_customer_gateway.ldn_office.type

  tags = {
    "Name" = "London Office S2S VPN"
  }
}