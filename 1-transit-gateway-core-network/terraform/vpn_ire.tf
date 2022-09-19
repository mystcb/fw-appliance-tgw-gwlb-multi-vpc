#
# Example for a Ireland Office VPN connection, connected to the Ireland Region
#

# Customer Gateway for the S2S VPN, note the separate BGP ASN
resource "aws_customer_gateway" "ire_office" {
  bgp_asn    = var.ire_office_asn
  ip_address = var.ire_cgw
  type       = "ipsec.1"
  provider   = aws.ireland

  tags = {
    "Name" = "Ireland-Office-CGW"
  }

}

# Site to Site VPN connection connected to the Transit Gatway in Ireland
resource "aws_vpn_connection" "ire_office" {
  customer_gateway_id = aws_customer_gateway.ire_office.id
  transit_gateway_id  = aws_ec2_transit_gateway.ire.id
  type                = aws_customer_gateway.ire_office.type
  provider            = aws.ireland

  tags = {
    "Name" = "Ireland Office S2S VPN"
  }
}