terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Use a separate provider to create the certificate in a different region
# This is so the certificate can be picked up by Cloudfront
provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}