data "aws_vpc" "default" { default = true }
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
resource "aws_ecs_cluster" "app" {
  name = "app-prod-cluster"
}
resource "aws_security_group" "nlb" {
  name = "app-prod-nlb-sg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "tasks" {
  name = "app-prod-tasks-sg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    security_groups = [aws_security_group.nlb.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_lb" "nlb" {
  name = "app-prod-nlb"
  load_balancer_type = "network"
  internal = false
  subnets = data.aws_subnets.default.ids
  security_groups = [aws_security_group.nlb.id]
}
resource "aws_lb_target_group" "app" {
  name = "app-prod-tg"
  port = 8000
  protocol = "TCP"
  target_type = "ip"
  vpc_id = data.aws_vpc.default.id
  health_check {
    protocol = "HTTP"
    path = "/health"
    port = "8000"
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.nlb.arn
  port = 80
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
