# 도시 리스트 선언
variable "cities" {
  description = "List of cities"
  type        = list(string)
  default     = ["Seoul", "Tokyo", "New York"]
}

# 각 도시 앞에 접두사 추가
locals {
  prefixed_cities = [for city in var.cities : "City: ${city}"]
}

# 출력값 정의
output "formatted_cities" {
  description = "List of cities with prefix"
  value       = local.prefixed_cities
}

