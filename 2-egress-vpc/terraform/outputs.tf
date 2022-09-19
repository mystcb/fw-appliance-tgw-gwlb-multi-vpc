# GWLB Service Endpoint Service Name
output "gwlb_service_name" {
  value = aws_vpc_endpoint_service.gwlb.service_name
}

# Transit Gateway ID
output "tgw_service_name" {
  value = aws_ec2_transit_gateway.main_tgw.id
}