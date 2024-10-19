resource "aws_kms_key" "demo_applications_key" {
  description = "demo applications key"
}

resource "aws_codeartifact_domain" "my-jpmc" {
  domain         = "my-jpmc"
  encryption_key = aws_kms_key.demo_applications_key.arn
}

resource "aws_codeartifact_repository" "demo_applications" {
  repository = "demo-applications"
  domain     = aws_codeartifact_domain.my-jpmc.domain
}