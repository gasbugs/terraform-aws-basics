# Terraform 설정 및 AWS provider 설정
terraform {
  required_version = ">= 1.9.6" # Terraform의 최소 요구 버전을 1.9.6 이상으로 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws" # AWS 프로바이더의 소스를 HashiCorp 레지스트리로 지정
      version = ">= 5.73.0"     # AWS 프로바이더의 최소 버전을 5.73.0 이상으로 설정
    }
  }
}

provider "aws" {
  region  = "us-east-1"  # AWS 리전을 us-east-1로 설정
  profile = "my-profile" # AWS CLI의 "my-profile" 프로파일을 사용
}

# 예시 1: count를 사용한 반복
resource "aws_instance" "example1" {
  count         = 3                       # 3개의 인스턴스를 생성
  ami           = "ami-0c55b159cbfafe1f0" # 사용할 AMI ID
  instance_type = "t2.micro"              # EC2 인스턴스 유형 설정

  tags = {
    Name = "Example-Instance-${count.index}" # 각 인스턴스에 고유한 이름 태그 지정
    # (예: "Example-Instance-0", "Example-Instance-1")
  }
}

# 예시 2: for_each를 사용한 반복
resource "aws_instance" "example2" {
  for_each      = toset(["dev", "staging", "prod"]) # 환경별(dev, staging, prod)로 인스턴스를 생성
  ami           = "ami-0c55b159cbfafe1f0"           # 사용할 AMI ID
  instance_type = "t2.micro"                        # EC2 인스턴스 유형 설정

  tags = {
    Name = "Example-Instance-${each.key}" # 각 환경에 맞는 고유 이름 태그 지정
    # (예: "Example-Instance-dev")
  }
}

# 예시 3: for 표현식을 사용한 값 생성
locals {
  name_tags = [for name in var.instance_names : "Name-${name}"]
  # instance_names 목록의 각 항목에 "Name-" 접두사를 추가해 태그 이름을 생성
  # (예: ["Name-web1", "Name-web2", "Name-db1"])
}

# 예시 4: dynamic 블록을 사용한 리소스 생성
resource "aws_security_group" "example" {
  name = "example-sg" # 보안 그룹 이름 설정

  dynamic "ingress" {
    for_each = var.ingress_rules # ingress_rules 변수의 각 항목을 순회하며 인그레스 규칙 생성
    content {
      from_port   = ingress.value.from_port   # 시작 포트 번호 설정
      to_port     = ingress.value.to_port     # 종료 포트 번호 설정
      protocol    = ingress.value.protocol    # 프로토콜 설정 (예: TCP, UDP)
      cidr_blocks = ingress.value.cidr_blocks # CIDR 형식의 허용 IP 블록 설정
    }
  }
}
