variable "vpc_name" {
  description = "VPC의 이름" # VPC의 이름을 지정하는 변수
  type        = string    # 변수 타입은 문자열
}

variable "cidr_block" {
  description = "VPC의 CIDR 블록" # VPC의 CIDR 블록을 지정하는 변수
  type        = string         # 변수 타입은 문자열
}
