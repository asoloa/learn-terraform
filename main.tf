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
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
