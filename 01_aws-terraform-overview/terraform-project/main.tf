terraform {
  required_version = ">=1.9.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.73.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "my-profile"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t2.micro"
}
