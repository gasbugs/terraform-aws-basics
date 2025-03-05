# 변수 선언
variable "greeting" {
  description = "The greeting message"
  type        = string
  default     = "Hello, Terraform!"
}

# 출력값 정의
output "greeting_message" {
  description = "Display the greeting message"
  value       = "The greeting message is: ${var.greeting}"
}
