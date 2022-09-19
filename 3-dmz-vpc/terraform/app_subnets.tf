# The the creation of each subnet
resource "aws_subnet" "app_subnets" {
  count  = length(var.app_sn_ranges)
  vpc_id = aws_vpc.dmz_vpc.id

  cidr_block        = element(concat(var.app_sn_ranges, [""]), count.index)
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]
  tags = {
    Name = "app_sn_${count.index}"
  }
}

# Route Table for the App Subnets
resource "aws_route_table" "app_rt" {
  vpc_id = aws_vpc.dmz_vpc.id

  route = []

  tags = {
    "Name" = "APP_RT"
  }
}

# TGW needs to be created before this is uncommented
resource "aws_route" "app_tgw_route" {
  route_table_id         = aws_route_table.app_rt.id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = aws_ec2_transit_gateway_vpc_attachment.tgwa.transit_gateway_id
  depends_on = [
    aws_route_table.app_rt,
    aws_ec2_transit_gateway_vpc_attachment.tgwa
  ]
}