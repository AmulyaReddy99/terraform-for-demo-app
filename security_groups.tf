
# 2 security groups
resource "aws_security_group" "lb_sg" {
  name        = "ApplicationLoadBalancerSecurityGroup"
  description = "Allow inbound traffic port 80 from anywhere"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_all_traffic_to_alb"
  }
}

resource "aws_security_group_rule" "allow_http_ipv4_lb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
#   source_security_group_id = aws_security_group.lb_sg.id
  security_group_id        = aws_security_group.lb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4_lb" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
#   source_security_group_id = aws_security_group.lb_sg.id
  security_group_id        = aws_security_group.lb_sg.id
}

# ------------

resource "aws_security_group" "demo-app-sg" {
  name        = "ContainerFromALBSecurityGroup"
  description = "Inbound traffic from ApplicationLoadBalancerSecurityGroup"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_alb_traffic"
  }
}

resource "aws_security_group_rule" "allow_alb_ipv4" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_sg.id
#   cidr_blocks              = [aws_security_group.demo-app-sg.id]
  security_group_id        = aws_security_group.demo-app-sg.id
}

resource "aws_security_group_rule" "allow_all_traffic_ipv4" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
#   source_security_group_id = aws_security_group.demo-app-sg.id
  security_group_id        = aws_security_group.demo-app-sg.id
}

# -----

resource "aws_security_group" "react-micro-frontend-sg" {
  name        = "ReactMicroFrontendSecuityGroup"
  description = "Inbound traffic from anywhere to 9000 port"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_react_traffic"
  }
}

resource "aws_security_group_rule" "allow_react_ipv4" {
  type                     = "ingress"
  from_port                = 9000
  to_port                  = 9000
  protocol                 = "tcp"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.react-micro-frontend-sg.id
}

resource "aws_security_group_rule" "allow_react_traffic_ipv4" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = aws_security_group.react-micro-frontend-sg.id
}