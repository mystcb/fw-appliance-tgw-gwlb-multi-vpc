#
# BGP ASN configuration, note that each separated region should ideally have
# it's own ASN to enable the mesh network to route traffic intelegently between
# regions.
#

## ASN's for the AWS regions
variable "ldn_asn" {
  description = "The BGP ASN for the London Region"
  type        = string
  default     = "64520"
}

variable "ire_asn" {
  description = "The BGP ASN for the Ireland Region"
  type        = string
  default     = "64521"
}

variable "use_asn" {
  description = "The BGP ASN for the North Virginia Region"
  type        = string
  default     = "64522"
}

variable "fra_asn" {
  description = "The BGP ASN for the Frankfurt Region"
  type        = string
  default     = "64523"
}

variable "sin_asn" {
  description = "The BGP ASN for the Singapore Region"
  type        = string
  default     = "64524"
}

## ASN's for the Office Sites
variable "ldn_office_asn" {
  description = "The BGP ASN for the London Office"
  type        = string
  default     = "64530"
}

variable "ire_office_asn" {
  description = "The BGP ASN for the Ireland Office"
  type        = string
  default     = "64531"
}

variable "fra_office_asn" {
  description = "The BGP ASN for the Frankfurt Office"
  type        = string
  default     = "64532"
}

variable "use_office_asn" {
  description = "The BGP ASN for the North Virginia Office"
  type        = string
  default     = "64533"
}

variable "sin_office_asn" {
  description = "The BGP ASN for the Singapore Office"
  type        = string
  default     = "64533"
}

#
# S2S VPN connections - used as an example, these variables are for S2S VPNs
# linked up to their local regions.
#
variable "ldn_cgw" {
  description = "This is the external IP of the CGW for the S2S VPN in London"
  type        = string
  default     = "1.1.1.1"
}

variable "ire_cgw" {
  description = "This is the external IP of the CGW for the S2S VPN in Ireland"
  type        = string
  default     = "2.2.2.2"
}

variable "use_cgw" {
  description = "This is the external IP of the CGW for the S2S VPN in North Virginia"
  type        = string
  default     = "3.3.3.3"
}

variable "fra_cgw" {
  description = "This is the external IP of the CGW for the S2S VPN in Frankfurt"
  type        = string
  default     = "4.4.4.4"
}

variable "sin_cgw" {
  description = "This is the external IP of the CGW for the S2S VPN in Singapore"
  type        = string
  default     = "5.5.5.5"
}