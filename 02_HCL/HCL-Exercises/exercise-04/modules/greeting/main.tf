# 출력 메시지 정의
output "full_greeting" {
  description = "The complete greeting message"
  value       = "${var.message_prefix}${var.greeting}"
}
