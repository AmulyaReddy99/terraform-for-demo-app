resource "aws_ecs_cluster" "demo_applications" {
  name = "demo-applications"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}