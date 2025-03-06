resource "local_file" "example" {
  filename = "${path.module}/${var.filename}" # .\test.txt
  content  = "Hello, Terraform!"
}
