# Terraform 초기 설정
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# 숫자 함수 예제: 두 숫자 중 최대값 구하기
variable "num1" {
  default = 10
}

variable "num2" {
  default = 20
}

output "max_value" {
  value = max(var.num1, var.num2) # num1과 num2 중 최대값
}

# 문자열 함수 예제
variable "greeting" {
  default = "hello, terraform"
}

output "upper_greeting" {
  value = upper(var.greeting) # 문자열을 대문자로 변환
}

output "greeting_list" {
  value = split(", ", var.greeting) # 문자열을 구분자로 나누어 리스트로 변환
}

# 컬렉션 함수 예제
variable "fruit_list" {
  default = ["apple", "banana", "cherry"]
}

output "joined_fruit" {
  value = join(", ", var.fruit_list) # 리스트를 콤마로 구분하여 문자열로 결합
}

# 변환 함수 예제
variable "bool_value" {
  default = true
}

output "string_value" {
  value = tostring(var.bool_value) # 불리언 값을 문자열로 변환
}

# 파일 함수 예제: config.txt 파일 내용 가져오기 (로컬에 파일이 있어야 합니다)
variable "config_path" {
  default = "config.txt"
}

check "config_file_exists" {
  assert {
    condition     = fileexists(var.config_path) # 파일 존재 여부 확인
    error_message = "Configuration file does not exist at the specified path."
  }
}

output "file_content" {
  value = file(var.config_path) # 파일 내용을 출력
}

# 네트워크 함수 예제
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

output "subnet_cidr" {
  value = cidrsubnet(var.vpc_cidr, 8, 1) # CIDR을 서브넷으로 나눠서 반환
}

output "host_ip" {
  value = cidrhost(var.vpc_cidr, 5) # 지정한 호스트 번호의 IP 주소 반환
}

# 랜덤 정수 생성
resource "random_integer" "example" {
  min = 1
  max = 100
}

output "random_integer_value" {
  value = random_integer.example.result # 랜덤 정수 값 출력
}
