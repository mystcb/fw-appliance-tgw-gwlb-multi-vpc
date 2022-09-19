#
# To ensure that traffic is routed to the Firewall Appliances for external
# traffic, Transit Gateway Routing needs to be created at this level, so that
# when attachments are made, they can be attached to these route tables which
# are controlled by the Transit account.
#

# Egress Route table for the London Region
resource "aws_ec2_transit_gateway_route_table" "egress_tgw_ldn_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.ldn.id
  tags = {
    "Name" = "Egress Traffic for London route table"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_ldn_route" {
  destination_cidr_block = "0.0.0.0/0"
  # transit_gateway_attachment_id = this is where the attachment ID would need to be for the Egress VPN
  blackhole                      = true # used for the example only, delete if above used
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_tgw_ldn_rt.id

}

# Egress Route table for the Ireland Region
resource "aws_ec2_transit_gateway_route_table" "egress_tgw_ire_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.ire.id
  provider           = aws.ireland
  tags = {
    "Name" = "Egress Traffic for Ireland route table"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_ire_route" {
  destination_cidr_block = "0.0.0.0/0"
  # transit_gateway_attachment_id = this is where the attachment ID would need to be for the Egress VPN
  blackhole                      = true # used for the example only, delete if above used
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_tgw_ire_rt.id
  provider                       = aws.ireland

}

# Egress Route table for the North Virginia Region
resource "aws_ec2_transit_gateway_route_table" "egress_tgw_use_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.use.id
  provider           = aws.us-east
  tags = {
    "Name" = "Egress Traffic for North Virginia route table"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_use_route" {
  destination_cidr_block = "0.0.0.0/0"
  # transit_gateway_attachment_id = this is where the attachment ID would need to be for the Egress VPN
  blackhole                      = true # used for the example only, delete if above used
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_tgw_use_rt.id
  provider                       = aws.us-east

}

# Egress Route table for the Frankfurt Region
resource "aws_ec2_transit_gateway_route_table" "egress_tgw_fra_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.fra.id
  provider           = aws.frankfurt
  tags = {
    "Name" = "Egress Traffic for Frankfurt route table"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_fra_route" {
  destination_cidr_block = "0.0.0.0/0"
  # transit_gateway_attachment_id = this is where the attachment ID would need to be for the Egress VPN
  blackhole                      = true # used for the example only, delete if above used
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_tgw_fra_rt.id
  provider                       = aws.frankfurt

}

# Egress Route table for the Singapre Region
resource "aws_ec2_transit_gateway_route_table" "egress_tgw_sin_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.sin.id
  provider           = aws.singapore
  tags = {
    "Name" = "Egress Traffic for Singapore route table"
  }
}

resource "aws_ec2_transit_gateway_route" "egress_vpc_sin_route" {
  destination_cidr_block = "0.0.0.0/0"
  # transit_gateway_attachment_id = this is where the attachment ID would need to be for the Egress VPN
  blackhole                      = true # used for the example only, delete if above used
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_tgw_sin_rt.id
  provider                       = aws.singapore

}

#
# For the Egress VPC to be able to route traffic back to the instances in the
# additional accounts and Spoke VPC's can be returned without looping back to
# the Checkpoint as the above routes would cause this.
#

# Egress VPC's Route table to access other accounts for the London Region
resource "aws_ec2_transit_gateway_route_table" "egress_vpc_tgw_ldn_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.ldn.id
  tags = {
    "Name" = "Egress VPC routing for London region"
  }
}

# Route propergation entry for the VPN connection
resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_ldn_route_prop" {
  transit_gateway_attachment_id  = aws_vpn_connection.ldn_office.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_ldn_rt.id
}

# Other route propergations require a VPC attachment to use
# resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_ldn_route_prop" {
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_ldn_rt.id
# }

# Egress VPC's Route table to access other accounts for the Ireland Region
resource "aws_ec2_transit_gateway_route_table" "egress_vpc_tgw_ire_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.ire.id
  provider           = aws.ireland
  tags = {
    "Name" = "Egress VPC routing for Ireland region"
  }
}

# Route propergation entry for the VPN connection
resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_ire_route_prop" {
  transit_gateway_attachment_id  = aws_vpn_connection.ire_office.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_ire_rt.id
  provider                       = aws.ireland
}

# Other route propergations require a VPC attachment to use
# resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_ire_route_prop" {
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_ire_rt.id
#   provider = aws.ireland
# }

# Egress VPC's Route table to access other accounts for the North Virginia Region
resource "aws_ec2_transit_gateway_route_table" "egress_vpc_tgw_use_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.use.id
  provider           = aws.us-east
  tags = {
    "Name" = "Egress VPC routing for North Virginia region"
  }
}

# Other route propergations require a VPC attachment to use
# resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_use_route_prop" {
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_use_rt.id
#   provider = aws.us-east
# }

# Egress VPC's Route table to access other accounts for the North Virginia Region
resource "aws_ec2_transit_gateway_route_table" "egress_vpc_tgw_fra_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.fra.id
  provider           = aws.frankfurt
  tags = {
    "Name" = "Egress VPC routing for Frankfurt region"
  }
}

# Other route propergations require a VPC attachment to use
# resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_fra_route_prop" {
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_fra_rt.id
#   provider = aws.frankfurt
# }

# Egress VPC's Route table to access other accounts for the North Virginia Region
resource "aws_ec2_transit_gateway_route_table" "egress_vpc_tgw_sin_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.sin.id
  provider           = aws.singapore
  tags = {
    "Name" = "Egress VPC routing for Singapore region"
  }
}

# Other route propergations require a VPC attachment to use
# resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpc_tgw_sin_route_prop" {
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.egress_vpc_tgw_sin_rt.id
#   provider = aws.singapore
# }