#
# Peering to the Ireland (eu-west-1) Region
#

# Get the region information for the Ireland Region
data "aws_region" "ire" {
  provider = aws.ireland
}

# London to Ireland TGW Attachment (1)
resource "aws_ec2_transit_gateway_peering_attachment" "ldn2ire" {
  peer_account_id         = aws_ec2_transit_gateway.ire.owner_id
  peer_region             = data.aws_region.ire.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.ire.id
  transit_gateway_id      = aws_ec2_transit_gateway.ldn.id

  tags = {
    "Name" = "London to Ireland Transit Peering Requestor"
  }
}

# Accept the London to Ireland TGW Attachment (1)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ldn2ire" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ldn2ire.id
  provider                      = aws.ireland
  tags = {
    "Name" = "London to Ireland Transit Peering Accepter"
  }
}

#
# Peering to the North Virginia (us-east-1) Region
#

# Get the region information for the North Virginia Region
data "aws_region" "use" {
  provider = aws.us-east
}

# London to North Virginia TGW Attachment (2)
resource "aws_ec2_transit_gateway_peering_attachment" "ldn2use" {
  peer_account_id         = aws_ec2_transit_gateway.use.owner_id
  peer_region             = data.aws_region.use.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.use.id
  transit_gateway_id      = aws_ec2_transit_gateway.ldn.id

  tags = {
    "Name" = "London to North Virginia Transit Peering Requestor"
  }
}

# Accept the London to North Virginia TGW Attachment (2)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ldn2use" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ldn2use.id
  provider                      = aws.us-east
  tags = {
    "Name" = "London to North Virginia Transit Peering Accepter"
  }
}

#
# Peering to the Frankfurt (eu-central-1) Region
#

# Get the region information for the Frankfurt Region
data "aws_region" "fra" {
  provider = aws.frankfurt
}

# London to Frankfirt TGW Attachment (7)
resource "aws_ec2_transit_gateway_peering_attachment" "ldn2fra" {
  peer_account_id         = aws_ec2_transit_gateway.fra.owner_id
  peer_region             = data.aws_region.fra.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.fra.id
  transit_gateway_id      = aws_ec2_transit_gateway.ldn.id

  tags = {
    "Name" = "London to Frankfurt Transit Peering Requestor"
  }
}

# Accept the London to Frankfurt TGW Attachment (7)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ldn2fra" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ldn2fra.id
  provider                      = aws.frankfurt
  tags = {
    "Name" = "London to Frankfurt Transit Peering Accepter"
  }
}

#
# Peering to the Singapore (ap-northeast-1) Region
#

# Get the region information for the Singapore Region
data "aws_region" "sin" {
  provider = aws.singapore
}

# London to Singapore TGW Attachment (4)
resource "aws_ec2_transit_gateway_peering_attachment" "ldn2sin" {
  peer_account_id         = aws_ec2_transit_gateway.sin.owner_id
  peer_region             = data.aws_region.sin.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.sin.id
  transit_gateway_id      = aws_ec2_transit_gateway.ldn.id

  tags = {
    "Name" = "London to Singapore Transit Peering Requestor"
  }
}

# Accept the London to Singapore TGW Attachment (4)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ldn2sin" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ldn2sin.id
  provider                      = aws.singapore
  tags = {
    "Name" = "London to Singapore Transit Peering Accepter"
  }
}


##
## Mesh connections, outside of the London Primary
##

#
# Peering from Ireland Region to make a mesh network
#

# Ireland to North Virginia TGW Attachment (3)
resource "aws_ec2_transit_gateway_peering_attachment" "ire2use" {
  peer_account_id         = aws_ec2_transit_gateway.use.owner_id
  peer_region             = data.aws_region.use.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.use.id
  transit_gateway_id      = aws_ec2_transit_gateway.ire.id

  provider = aws.ireland

  tags = {
    "Name" = "Ireland to North Virginia Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.ire,
    aws_ec2_transit_gateway.use,
    aws_ec2_transit_gateway_peering_attachment.ldn2ire,
    aws_ec2_transit_gateway_peering_attachment.ldn2use
  ]
}

# Accept the Ireland to North Virginia TGW Attachment (3)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ire2use" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ire2use.id
  provider                      = aws.us-east

  tags = {
    "Name" = "Ireland to North Virginia Transit Peering Accepter"
  }
}

# Ireland to Frankfurt TGW Attachment (8)
resource "aws_ec2_transit_gateway_peering_attachment" "ire2fra" {
  peer_account_id         = aws_ec2_transit_gateway.fra.owner_id
  peer_region             = data.aws_region.fra.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.fra.id
  transit_gateway_id      = aws_ec2_transit_gateway.ire.id

  provider = aws.ireland

  tags = {
    "Name" = "Ireland to Frankfurt Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.ire,
    aws_ec2_transit_gateway.fra,
    aws_ec2_transit_gateway_peering_attachment.ldn2ire,
    aws_ec2_transit_gateway_peering_attachment.ldn2fra
  ]
}

# Accept the Ireland to Frankfurt TGW Attachment (8)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ire2fra" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ire2fra.id
  provider                      = aws.frankfurt

  tags = {
    "Name" = "Ireland to Frankfurt Transit Peering Accepter"
  }
}

# Ireland to Singapore TGW Attachment (5)
resource "aws_ec2_transit_gateway_peering_attachment" "ire2sin" {
  peer_account_id         = aws_ec2_transit_gateway.sin.owner_id
  peer_region             = data.aws_region.sin.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.sin.id
  transit_gateway_id      = aws_ec2_transit_gateway.ire.id

  provider = aws.ireland

  tags = {
    "Name" = "Ireland to Singapore Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.ire,
    aws_ec2_transit_gateway.sin,
    aws_ec2_transit_gateway_peering_attachment.ldn2ire,
    aws_ec2_transit_gateway_peering_attachment.ldn2sin
  ]
}

# Accept the Ireland to Singapore TGW Attachment (5)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ire2sin" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.ire2sin.id
  provider                      = aws.singapore

  tags = {
    "Name" = "Ireland to Singapore Transit Peering Accepter"
  }
}

#
# Peering from Frankfurt Region to make a mesh network
#

# Frankfurt to North Virginia TGW Attachment (9)
resource "aws_ec2_transit_gateway_peering_attachment" "fra2use" {
  peer_account_id         = aws_ec2_transit_gateway.use.owner_id
  peer_region             = data.aws_region.use.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.use.id
  transit_gateway_id      = aws_ec2_transit_gateway.fra.id

  provider = aws.frankfurt

  tags = {
    "Name" = "Frankfurt to North Virginia Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.fra,
    aws_ec2_transit_gateway.use,
    aws_ec2_transit_gateway_peering_attachment.ldn2fra,
    aws_ec2_transit_gateway_peering_attachment.ldn2use
  ]
}

# Accept the Frankfurt to North Virginia TGW Attachment (9)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "fra2use" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.fra2use.id
  provider                      = aws.us-east

  tags = {
    "Name" = "Frankfurt to North Virginia Transit Peering Accepter"
  }
}

# Frankfurt to Singapore TGW Attachment (10)
resource "aws_ec2_transit_gateway_peering_attachment" "fra2sin" {
  peer_account_id         = aws_ec2_transit_gateway.sin.owner_id
  peer_region             = data.aws_region.sin.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.sin.id
  transit_gateway_id      = aws_ec2_transit_gateway.fra.id

  provider = aws.frankfurt

  tags = {
    "Name" = "Frankfurt to Singapore Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.fra,
    aws_ec2_transit_gateway.sin,
    aws_ec2_transit_gateway_peering_attachment.ldn2fra,
    aws_ec2_transit_gateway_peering_attachment.ldn2sin
  ]
}

# Accept the Frankfurt to Singapore TGW Attachment (10)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "fra2sin" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.fra2sin.id
  provider                      = aws.singapore

  tags = {
    "Name" = "Frankfurt to Singapore Transit Peering Accepter"
  }
}

#
# Peering from Sinapore Region to make a mesh network
#

# Singapore to North Virginia TGW Attachment (6)
resource "aws_ec2_transit_gateway_peering_attachment" "sin2use" {
  peer_account_id         = aws_ec2_transit_gateway.use.owner_id
  peer_region             = data.aws_region.use.name
  peer_transit_gateway_id = aws_ec2_transit_gateway.use.id
  transit_gateway_id      = aws_ec2_transit_gateway.sin.id

  provider = aws.singapore

  tags = {
    "Name" = "Singapore to North Virginia Transit Peering Requestor"
  }

  depends_on = [
    aws_ec2_transit_gateway.sin,
    aws_ec2_transit_gateway.use,
    aws_ec2_transit_gateway_peering_attachment.ldn2sin,
    aws_ec2_transit_gateway_peering_attachment.ldn2use
  ]
}

# Accept the Singapore to North Virginia TGW Attachment (6)
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "sin2use" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.sin2use.id
  provider                      = aws.us-east

  tags = {
    "Name" = "Frankfurt to North Virginia Transit Peering Accepter"
  }
}