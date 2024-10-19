resource "aws_s3_bucket" "example" {
  bucket = "amulya-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}