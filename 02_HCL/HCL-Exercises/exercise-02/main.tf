# 시간대 변수 선언
variable "is_day" {
  description = "Whether it is day or night"
  type        = bool
  default     = false
}

# 동적 인사말 설정
locals {
  greeting = var.is_day ? "Good day!" : "Good night!"
}

# 출력값 정의
output "greeting_message" {
  description = "The greeting message based on time of day"
  value       = local.greeting
}
