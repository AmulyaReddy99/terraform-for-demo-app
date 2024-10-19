
variable "ami_var" {
  description = "ami id"
}


# EC2
resource "aws_instance" "ec2_instance" {
  ami           = var.ami_var
  instance_type = "t2.micro"
  tags = {
    Name = "TestInstance123"
    env  = "development"
  }
}

# data "aws_instance" "test_data" {
#   filter {
#     name   = "tag:Name"
#     values = ["TestInstance123"]
#   }
# }
