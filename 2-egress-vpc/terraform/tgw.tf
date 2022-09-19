resource "aws_ec2_transit_gateway" "main_tgw" {
  amazon_side_asn                = 65510
  auto_accept_shared_attachments = "enable"
  description                    = "Main TGW for the network"
  tags = {
    "Name" = "Main-TGW"
  }
}