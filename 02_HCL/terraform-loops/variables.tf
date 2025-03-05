variable "instance_names" {
  description = "태깅에 사용할 인스턴스 이름 목록"
  type        = list(string)
  default     = ["web1", "web2", "web3"]
}

variable "ingress_rules" {
  description = "보안 그룹을 위한 인그레스 규칙 목록"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
