#
# Example for a Singapore Office VPN connection, connected to the Frankfurt Region
#

# Customer Gateway for the S2S VPN, note the separate BGP ASN
resource "aws_customer_gateway" "sin_office" {
  bgp_asn    = var.sin_office_asn
  ip_address = var.sin_cgw
  type       = "ipsec.1"
  provider   = aws.singapore

  tags = {
    "Name" = "Singapore-Office-CGW"
  }

}

# Site to Site VPN connection connected to the Transit Gatway in Singapore
resource "aws_vpn_connection" "sin_office" {
  customer_gateway_id = aws_customer_gateway.sin_office.id
  transit_gateway_id  = aws_ec2_transit_gateway.sin.id
  type                = aws_customer_gateway.sin_office.type
  provider            = aws.singapore

  tags = {
    "Name" = "Singapore Office S2S VPN"
  }
}