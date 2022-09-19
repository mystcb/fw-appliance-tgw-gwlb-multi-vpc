# Create an endpoint per Subnet as GWLB Endpoints are single VPC only
resource "aws_vpc_endpoint" "gwlb_endpoint_a" {
  vpc_id            = aws_vpc.dmz_vpc.id
  service_name      = var.gwlbe_service_name
  subnet_ids        = [aws_subnet.gwlbe_subnets[0].id]
  vpc_endpoint_type = "GatewayLoadBalancer"
  tags = {
    "Name" = "Gateway Load Balancer Endpoint A"
  }
}

resource "aws_vpc_endpoint" "gwlb_endpoint_b" {
  vpc_id            = aws_vpc.dmz_vpc.id
  service_name      = var.gwlbe_service_name
  subnet_ids        = [aws_subnet.gwlbe_subnets[1].id]
  vpc_endpoint_type = "GatewayLoadBalancer"
  tags = {
    "Name" = "Gateway Load Balancer Endpoint B"
  }
}