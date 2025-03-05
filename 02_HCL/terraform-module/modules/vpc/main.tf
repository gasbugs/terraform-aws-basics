resource "aws_vpc" "this" {
  cidr_block = var.cidr_block # VPC의 CIDR 블록을 변수로 설정하여 유연성 제공
  tags = {
    Name = var.vpc_name # VPC의 이름 태그를 변수로 설정
  }
}
