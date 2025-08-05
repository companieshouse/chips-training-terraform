terraform {
  required_version = ">= 1.3"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.37.0, < 6.0.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.25.0, < 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
