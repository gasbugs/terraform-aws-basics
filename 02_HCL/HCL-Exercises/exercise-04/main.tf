# 모듈 호출
module "greeting_message" {
  source         = "./modules/greeting"
  greeting       = "Hello"
  message_prefix = "Welcome: "
}

# 모듈에서 출력된 인사 메시지 출력
output "final_greeting" {
  description = "The final greeting message"
  value       = module.greeting_message.full_greeting
}
