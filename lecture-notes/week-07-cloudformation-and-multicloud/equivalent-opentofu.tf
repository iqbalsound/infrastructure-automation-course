# Equivalent cloud-agnostic style (Terraform/OpenTofu, illustrative)
resource "local_file" "bucket_placeholder" {
  filename = "./course-demo-bucket/.keep"
  content  = "placeholder for storage bucket concept"
}
