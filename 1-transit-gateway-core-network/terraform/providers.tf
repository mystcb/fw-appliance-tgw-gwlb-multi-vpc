# London is the default region
provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      "Source" = "terraform"
      "Owner"  = "Customer Name"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "ireland"

  default_tags {
    tags = {
      "Source" = "terraform"
      "Owner"  = "Customer Name"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"

  default_tags {
    tags = {
      "Source" = "terraform"
      "Owner"  = "Customer Name"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  alias  = "frankfurt"

  default_tags {
    tags = {
      "Source" = "terraform"
      "Owner"  = "Customer Name"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "singapore"

  default_tags {
    tags = {
      "Source" = "terraform"
      "Owner"  = "Customer Name"
    }
  }
}