# Terraform 설정 및 AWS provider 설정
terraform {
  required_version = ">= 1.9.6" # Terraform의 최소 요구 버전을 1.9.6 이상으로 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws" # AWS 프로바이더의 소스 지정
      version = ">= 5.73.0"     # AWS 프로바이더 버전 5.73 이상 사용
    }
  }
}

provider "aws" {
  region  = "us-east-1"  # AWS 리전을 us-east-1로 설정
  profile = "my-profile" # AWS CLI의 "my-profile" 프로파일을 사용
}

# al2023 이미지 정보 가져오기
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

# Ubuntu 이미지 정보 가져오기
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical의 AWS 계정 ID

  filter {
    name   = "name"
    values = ["ubuntu"] # Ubuntu
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # 아키텍처 설정
  }
}


# 리소스 간 의존성 설정
resource "aws_security_group" "example_sg" {
  name = "example-sg" # 보안 그룹 이름 설정
}


# EC2 인스턴스 생성 전 생명 주기 제어
resource "aws_instance" "example_create_before_destroy_with_dependency" {
  ami           = data.aws_ami.al2023  # 설정한 AMI ID 사용
  instance_type = "t2.micro" # EC2 인스턴스 유형 설정

  lifecycle {
    create_before_destroy = true # 인스턴스를 교체할 때 새 인스턴스를 먼저 생성하고 기존 인스턴스를 삭제하여 다운타임을 방지
  }

  depends_on = [
    aws_security_group.example_sg # 보안 그룹 생성 후 인스턴스를 생성하도록 의존성 설정
  ]
}

# 중요 리소스의 삭제 방지 (S3 이름에 랜덤 숫자 생성)
resource "random_integer" "rand_num" {
  min = 1000 # 랜덤 숫자의 최소값 설정
  max = 9999 # 랜덤 숫자의 최대값 설정
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-important-bucket-${random_integer.rand_num.result}" # S3 버킷 이름에 랜덤 숫자를 추가하여 고유성 확보

  lifecycle {
    prevent_destroy = false # 삭제 방지 비활성화 (중요한 리소스일 경우 true로 설정 권장)
  }
}
