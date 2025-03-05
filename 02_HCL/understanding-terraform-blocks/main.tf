variable "filename" {
  description = "파일 이름 변수"

}

resource "local_file" "example" {
  filename = "${path.module}/${var.filename}"
  content  = "Hello, Terraform!"
}

output "file_path" {
  value = local_file.example.filename
}
