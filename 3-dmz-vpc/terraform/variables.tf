variable "aws_region" {
  description = "The region to pass to the AWS Terraform provider."
  type        = string
  default     = "eu-west-2"

  validation {
    condition     = can(regex("[a-z]{2}-[a-z]*-\\d", var.aws_region))
    error_message = "The supplied aws_region does not match the regex `[a-z]{2}-[a-z]*-\\d`."
  }
}

variable "vpc_cidr" {
  description = "The CIDR of the VPC."
  type        = string
  default     = "192.168.0.0/20"
}
variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "ProductionDMZ-VPC"
}

# Gateway Load Balancer Subnets
variable "gwlbe_sn_ranges" {
  description = "Ranges for the Gateway Load Balncer Endpoint Subnet."
  type        = list(string)
  default = [
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
}

# For this example to work, you will need the GWLB service name from the
# 2-egress-vpc Terraform deployment. This is extracted in the outputs.tf file so
# you just need to copy the name into here. Otherwise any existing GWLB VPC
# Endpoint would work for this example. Note that for any real world example
# it would be best to work this into an automated fill so that you do not
# have to do this manually.
variable "gwlbe_service_name" {
  description = "Gateway Load Balancer service name"
  type        = string
  default     = "com.amazonaws.vpce.region-name.vpce-svc-0123456789abcdefg"
}

# DMZ Subnet variables
variable "dmz_sn_ranges" {
  description = "Ranges for the DMZ Subnets."
  type        = list(string)
  default = [
    "192.168.3.0/24",
    "192.168.4.0/24"
  ]
}

# App Subnet variables
variable "app_sn_ranges" {
  description = "Ranges for the Application Subnets."
  type        = list(string)
  default = [
    "192.168.5.0/24",
    "192.168.6.0/24"
  ]
}

# Transit Gateway Attachment Subnet variables
variable "tgwa_sn_ranges" {
  description = "Ranges for the Transit Gateway Attachment Subnets."
  type        = list(string)
  default = [
    "192.168.7.0/24",
    "192.168.8.0/24"
  ]
}

# For this example to work, you will need the TGW ID from the 2-egress-vpc
# Terraform deployment. This is extracted in the outputs.tf file so you just
# need to copy the name into here. Otherwise any existing GWLB VPC Endpoint
# would work for this example. Note that for any real world example it would be
# best to work this into an automated fill so that you do not have to do this
# manually.
variable "tgw_id" {
  description = "Transit Gatway ARN for attachment"
  type        = string
  default     = "tgw-0123456789abcdefg"
}