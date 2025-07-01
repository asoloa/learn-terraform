terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0" # Latest version as of this writing
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}