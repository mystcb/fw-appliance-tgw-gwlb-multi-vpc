provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Source" = "terraform"
    }
  }
}
