terraform {
  required_version = ">=1.9.8"
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

resource "aws_instance" "example1" {
  count         = 3
  ami           = "ami-1234567890"
  instance_type = "t2.micro"

  tags = {
    Name = "Example-Instance-${count.index}" # 0, 1, 2
  }
}

resource "aws_instance" "example2" {
  for_each      = toset(["dev", "staging", "prod"])
  ami           = "ami-1234567890"
  instance_type = "t2.micro"
  tags = {
    Name = "Example-Instance-${each.key}" # ["dev", "staging", "prod"]
  }
}

locals {
  name_tags = [for name in var.instance_names : "Name-${name}"]
}

resource "aws_security_group" "example" {
  name = "example-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
