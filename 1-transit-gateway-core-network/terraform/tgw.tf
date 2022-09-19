#
# AWS Transit Gateways created in multiple regions, using London as the first
# region to ensure that the mesh network doesn't get stuck in a loop on creation
#
# Note: Route table association and propogation are disabled to ensure a fine
# grained control over the routes that are available in the routing table.
#

# London region TGW
resource "aws_ec2_transit_gateway" "ldn" {
  description                     = "London Network Transit Gateway"
  amazon_side_asn                 = var.ldn_asn
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    "Name" = "LondonTGW"
  }
}

# Ireland region TGW
resource "aws_ec2_transit_gateway" "ire" {
  description                     = "Ireland Network Transit Gateway"
  amazon_side_asn                 = var.ire_asn
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    "Name" = "IrelandTGW"
  }

  provider = aws.ireland
  depends_on = [
    aws_ec2_transit_gateway.ldn
  ]
}

# North Virginia region TGW
resource "aws_ec2_transit_gateway" "use" {
  description                     = "North Virginia Network Transit Gateway"
  amazon_side_asn                 = var.use_asn
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    "Name" = "NorthVirginiaTGW"
  }

  provider = aws.us-east
  depends_on = [
    aws_ec2_transit_gateway.ldn
  ]
}

# Frankfurt region TGW
resource "aws_ec2_transit_gateway" "fra" {
  description                     = "Frankfurt Network Transit Gateway"
  amazon_side_asn                 = var.fra_asn
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    "Name" = "FrankfurtTGW"
  }

  provider = aws.frankfurt
  depends_on = [
    aws_ec2_transit_gateway.ldn
  ]
}

# Singapore region TGW
resource "aws_ec2_transit_gateway" "sin" {
  description                     = "Singapore Network Transit Gateway"
  amazon_side_asn                 = var.sin_asn
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    "Name" = "SingaporeTGW"
  }

  provider = aws.singapore
  depends_on = [
    aws_ec2_transit_gateway.ldn
  ]
}