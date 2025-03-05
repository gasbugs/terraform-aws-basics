# Terraform 설정 및 AWS provider 설정
terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region  = "us-east-1" # 배포할 리전 
  profile = "my-profile"
}

# 예시 2: 동적인 값 할당
locals {
  instance_type = var.environment == "prod" ? "m5.large" : "t2.micro"
}

# 예시4: 맵을 통한 조건 값 선택
locals {
  ami_map = {
    "us-east-1" = "ami-063d43db0594b521b" # us-east-1에서 찾은 amazon linux 2023 ami
    "us-west-2" = "ami-066a7fbea5161f451" # us-west-2에서 찾은 amazon linux 2023 ami
  }

  selected_ami = local.ami_map[var.region != "" ? var.region : "us-east-1"] # 리전에 따라 ami 선택 
}

# EC2 인스턴스 생성
resource "aws_instance" "example" {
  ami           = local.selected_ami
  instance_type = local.instance_type # 예시 2와 연결 

  monitoring = var.enable_monitoring ? true : false                     # 예시 1: 변수 값 제어하기
  user_data  = var.custom_user_data != "" ? var.custom_user_data : null # 예시 5: null 활용하기
}

# 예시3: 조건에 따른 리소스 생성 제어
resource "aws_s3_bucket" "example" {
  count = var.create_bucket ? 1 : 0 # 생성 유무를 결정 

  bucket = "my-example-bucket"
}
