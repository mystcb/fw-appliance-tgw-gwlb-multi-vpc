#
# Example for a Frankfurt Office VPN connection, connected to the Frankfurt Region
#

# Customer Gateway for the S2S VPN, note the separate BGP ASN
resource "aws_customer_gateway" "fra_office" {
  bgp_asn    = var.fra_office_asn
  ip_address = var.fra_cgw
  type       = "ipsec.1"
  provider   = aws.frankfurt

  tags = {
    "Name" = "Frankfurt-Office-CGW"
  }

}

# Site to Site VPN connection connected to the Transit Gatway in Frankfurt
resource "aws_vpn_connection" "fra_office" {
  customer_gateway_id = aws_customer_gateway.fra_office.id
  transit_gateway_id  = aws_ec2_transit_gateway.fra.id
  type                = aws_customer_gateway.fra_office.type
  provider            = aws.frankfurt

  tags = {
    "Name" = "Frankfurt Office S2S VPN"
  }
}