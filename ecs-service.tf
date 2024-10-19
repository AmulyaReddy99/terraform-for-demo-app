resource "aws_lb_target_group" "ecs-demo-app-tg" {
  name     = "ecs-demo-app-tg"
  protocol             = "HTTP"
  target_type          = "ip"
  port                 = "80"
  vpc_id               = var.vpc_id
  deregistration_delay = 300


  health_check {
    path                = "/"
    protocol            = "HTTP"
  }
}

resource "aws_lb_listener" "demo_app_listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-demo-app-tg.arn
  }
}

# resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
#   target_group_arn = aws_lb_target_group.ecs-demo-app-tg.arn
#   target_id        = aws_ecs_service.demo-app.id
#   port             = 80
# }

# resource "aws_lb_target_group" "ecs-spring-webflux-app-tg" {
#   name     = "ecs-demo-app-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_ecs_service" "demo-app" {
#   name                = "demo-app"
#   cluster             = aws_ecr_repository.demo_applications.name
#   desired_count       = var.task_demo_app_desired_count
#   task_definition     = aws_ecs_task_definition.demo-applications.arn
#   scheduling_strategy = "REPLICA"

#   # 50 percent must be healthy during deploys
#   deployment_minimum_healthy_percent = 50
#   deployment_maximum_percent         = 100
  
#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs-demo-app-tg.arn
#     container_name   = "demo-app"
#     container_port   = var.demo_app_container_port
#   }

#   network_configuration {
#     # network_mode     = "awsvpc"
#     subnets          = [for subnet in data.aws_subnet.subnet : subnet.id]
#     security_groups  = [aws_security_group.demo-app-sg.id]
#   }
# }

# resource "aws_ecs_service" "spring-webflux-app" {
#   name                = "spring-webflux-app"
#   cluster             = aws_ecr_repository.demo_applications.name
#   desired_count       = var.task_demo_app_desired_count
#   task_definition     = aws_ecs_task_definition.demo-applications.arn
#   scheduling_strategy = "REPLICA"

#   # 50 percent must be healthy during deploys
#   deployment_minimum_healthy_percent = 50
#   deployment_maximum_percent         = 100
  
#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs-demo-app-tg.arn
#     container_name   = "spring-webflux-app"
#     container_port   = var.spring_webflux_app_container_port
#   }

#   network_configuration {
#     subnets          = [for subnet in data.aws_subnet.subnet : subnet.id]
#     security_groups  = [aws_security_group.demo-app-sg.id]
#   }
# }