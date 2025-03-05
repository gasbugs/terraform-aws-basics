####################################
# 기본 데이터 타입
# 문자열 변수
variable "instance_type" {
  description = "사용할 인스턴스 타입"
  type        = string
  default     = "t2.micro"
}

# 숫자 변수
variable "file_count" {
  description = "생성할 파일 수"
  type        = number
  default     = 2
}

# 불리언 변수
variable "create_files" {
  description = "파일을 생성할지 여부"
  type        = bool
  default     = true
}

####################################
# 복합 데이터 타입
# 리스트 변수
variable "file_name" {
  description = "생성할 파일 이름 목록"
  type        = list(string)
  default     = ["file1.txt", "file2.txt", "file3.txt"]
}

# set 변수
variable "unique_tags" {
  description = "고유한 태그를 설정"
  type        = set(string)
  default     = ["web", "production"]
}

# 맵 변수
variable "file_contents" {
  description = "파일 내용 맵"
  type        = map(string)
  default = {
    "file1.txt" = "This is file 1.",
    "file2.txt" = "This is file 2.",
    "file3.txt" = "This is file 3."
  }
}

# object 변수
variable "server_config" {
  description = "서버 설정을 포함하는 객체"
  type = object({
    name          = string
    instance_type = string
    disk_size     = number
  })
  default = {
    name          = "web-server"
    instance_type = "t2.micro"
    disk_size     = 50
  }
}

# 튜플 변수
variable "file_details" {
  description = "파일의 이름, 크기, 생성 여부"
  type        = tuple([string, number, bool])
  default     = ["file_details.txt", 10, true]
}

####################################
# 리소스: 파일 생성
resource "local_file" "example" {
  count    = var.create_files ? var.file_count : 0 # if # loop
  filename = var.file_name[count.index]
  content  = var.file_contents[var.file_name[count.index]]
}

####################################
# 출력: 생성된 파일 경로와 튜플 변수 출력
output "file_paths" {
  value = local_file.example[*].filename
}

output "file_details" {
  value = var.file_details
}

