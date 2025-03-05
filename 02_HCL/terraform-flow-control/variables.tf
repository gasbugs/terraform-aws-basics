# enable_monitoring 변수
variable "enable_monitoring" {
  description = "인스턴스에 대한 모니터링 활성화 여부를 결정합니다."
  type        = bool
  default     = true
}

# environment 변수
variable "environment" {
  description = "인스턴스가 배포되는 환경입니다. 이 변수에 따라 인스턴스 사양이 변경됩니다.(예: dev, prod)"
  type        = string
  default     = "dev"
}

# create_bucket 변수
variable "create_bucket" {
  description = "S3 버킷 생성 여부를 결정합니다."
  type        = bool
  default     = false
}

# region 변수
variable "region" {
  description = "리소스가 생성될 AWS 리전를 결정합니다."
  type        = string
  default     = "us-east-1"
}

# custom_user_data 변수
variable "custom_user_data" {
  description = "인스턴스에 전달할 사용자 지정 사용자 데이터를 명시합니다."
  type        = string
  default     = ""
}
