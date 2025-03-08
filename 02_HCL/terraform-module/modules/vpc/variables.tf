variable "cidr_block" {
  description = "VPC의 CIDR 블록"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  description = "VPC의 이름"
  type        = string
  default     = "your-vpc"
}
