resource "aws_ecr_repository" "demo_applications" {
  name = "demo-applications"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
