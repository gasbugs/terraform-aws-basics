# Terraform 설정
terraform {
  required_version = ">= 1.9.6" # Terraform의 최소 요구 버전을 1.9.6 이상으로 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws" # AWS 프로바이더의 소스를 HashiCorp 레지스트리로 지정
      version = ">= 5.73.0"     # AWS 프로바이더의 최소 버전을 5.73.0 이상으로 설정
    }
  }
}

# AWS 프로바이더 설정
provider "aws" {
  region  = "us-east-1"  # AWS 리전을 us-east-1로 설정
  profile = "my-profile" # AWS CLI의 프로파일 이름을 'my-profile'로 사용
}

# resource "aws_s3_bucket" "example" {
#   bucket        = "my-existing-bucket-202411121441"
#   bucket_prefix = null
#   tags          = {}
#   tags_all      = {}
# }

# S3 버킷 리소스 생성
resource "aws_s3_bucket" "example" {
  bucket = "my-existing-bucket-202411121441" # 생성할 S3 버킷 이름을 'my-existing-bucket-20241027'로 지정
}

# 기존 S3 버킷을 Terraform 상태와 연결
import {
  to = aws_s3_bucket.example             # Terraform 리소스 'aws_s3_bucket.example'와 연결
  id = "my-existing-bucket-202411121441" # 연결할 기존 버킷 ID (이름)
}
