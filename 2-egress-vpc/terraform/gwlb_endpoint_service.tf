# Create the endpoint service for the GWLB
resource "aws_vpc_endpoint_service" "gwlb" {
  acceptance_required        = false # For demonstration reasons
  gateway_load_balancer_arns = [aws_lb.gwlb.arn]
}

# Create the VPC Endpoints within the Firewall Appliance Subnet
resource "aws_vpc_endpoint" "gwlb" {
  count             = length(var.gwlbe_sn_ranges)
  vpc_id            = aws_vpc.egress_vpc.id
  service_name      = aws_vpc_endpoint_service.gwlb.service_name
  subnet_ids        = [aws_subnet.gwlbe_subnets[count.index].id]
  auto_accept       = true
  vpc_endpoint_type = "GatewayLoadBalancer"

  tags = {
    "Name" = "Firewall Appliance GWLB Endpoint"
  }
}