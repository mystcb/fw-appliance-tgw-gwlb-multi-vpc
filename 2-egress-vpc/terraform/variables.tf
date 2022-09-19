# Region to put the Egress VPC in
variable "aws_region" {
  description = "The region to pass to the AWS Terraform provider."
  type        = string
  default     = "eu-west-2"

  validation {
    condition     = can(regex("[a-z]{2}-[a-z]*-\\d", var.aws_region))
    error_message = "The supplied aws_region does not match the regex `[a-z]{2}-[a-z]*-\\d`."
  }
}

# This CIDR needs to represent ALL of the AWS CIDRs for additional VPCs
variable "aws_cidrs" {
  description = "The CIDR of the VPC."
  type        = string
  default     = "10.0.0.0/8"
}

# Give the Egress VPC its CIDR range
variable "vpc_cidr" {
  description = "The CIDR of the VPC."
  type        = string
  default     = "192.168.0.0/20"
}

# Name of the Egress VPC
variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "Egress-VPC"
}

# Gateway Load Balancer Subnets
variable "ngw_sn_ranges" {
  description = "Ranges for the NAT Gateway Subnets."
  type        = list(string)
  default = [
    "192.168.1.0/24",
    "192.168.2.0/24",
    "192.168.3.0/24"
  ]
}

# Firewall Appliance Subnets
variable "fwa_sn_ranges" {
  description = "Ranges for the Firewall Appliances Subnets."
  type        = list(string)
  default = [
    "192.168.4.0/24",
    "192.168.5.0/24",
    "192.168.6.0/24"
  ]
}

# Gateway Load Balancer Endpoint Subnets
variable "gwlbe_sn_ranges" {
  description = "Ranges for the Gateway Load Balancer VPC Endpoint Subnets."
  type        = list(string)
  default = [
    "192.168.8.0/28",
    "192.168.8.16/28",
    "192.168.8.32/28"
  ]
}

# Transit Gateway Subnets
variable "tgwa_sn_ranges" {
  description = "Ranges for the Transit Gateway Subnets."
  type        = list(string)
  default = [
    "192.168.9.0/28",
    "192.168.9.16/28",
    "192.168.9.32/28"
  ]
}
