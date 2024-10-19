data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

# ALB
resource "aws_lb" "application-load-balancer" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in data.aws_subnet.subnet : subnet.id]

  enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.id
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "production"
  }
}

# target group

# create secure run 3 tasks

# ERRORs
# task_execution_role not allowed to pull from ecr
# port not exposed, only tasks with exposed ports can have LB