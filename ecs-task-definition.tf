# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs_task_execution_role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Sid": "",
#         "Effect": "Allow",
#         "Principal": {
#             "Service": "ecs-tasks.amazonaws.com"
#         },
#         "Action": "sts:AssumeRole"
#         }
#     ]
#   })

#   tags = {
#     tag-key = "tag-value"
#   }
# }

data "aws_iam_role" "ecs_task_execution_role" {
  name = "MyDemoECSTaskExecutionRole"
}

resource "aws_ecs_task_definition" "demo-applications" {
  family                   = "demo-applications"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "demo-app",
    "image": "512458225546.dkr.ecr.ap-south-1.amazonaws.com/demo-applications:demo-app",
    "cpu": 512,
    "memory": 2048,
    "essential": true,
    "portMappings": [{ "containerPort": 8081 }]
  },
  {
    "name": "spring-webflux-app",
    "image": "512458225546.dkr.ecr.ap-south-1.amazonaws.com/demo-applications:spring-webflux-app",
    "cpu": 512,
    "memory": 2048,
    "essential": true,
    "portMappings": [{ "containerPort": 8099 }]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

resource "aws_ecs_task_definition" "react-micro-frontend" {
  family                   = "react-micro-frontend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "demo-app",
    "image": "512458225546.dkr.ecr.ap-south-1.amazonaws.com/demo-applications:react-micro-frontend",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [{ "containerPort": 9000 }]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}
