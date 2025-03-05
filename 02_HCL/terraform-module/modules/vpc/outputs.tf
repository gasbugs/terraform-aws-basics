output "vpc_id" {
  description = "VPC의 ID"       # 출력 값에 대한 설명
  value       = aws_vpc.this.id # 생성된 VPC 리소스의 ID 값을 출력
}
