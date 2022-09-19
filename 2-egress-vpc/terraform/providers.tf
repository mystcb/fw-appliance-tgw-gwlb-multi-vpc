provider "aws" {
  region = var.aws_region

  # Had to comment out due to: https://github.com/hashicorp/terraform-provider-aws/issues/20144
  # default_tags {
  #   tags = {
  #     "Source" = "terraform"
  #     "Owner"  = "Customer Name"
  #   }
  # }
}
