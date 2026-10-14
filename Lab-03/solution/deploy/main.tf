variable "task_definition_arn" {
  type = string
}
data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
data "aws_security_group" "tasks" {
  name = "app-prod-tasks-sg"
  vpc_id = data.aws_vpc.default.id
}
data "aws_lb_target_group" "app" {
  name = "app-prod-tg"
}
resource "aws_ecs_service" "app" {
  name = "app-service"
  cluster = "app-prod-cluster"
  task_definition = var.task_definition_arn
  desired_count = 3
  launch_type = "FARGATE"
  network_configuration {
    subnets = data.aws_subnets.default.ids
    security_groups = [data.aws_security_group.tasks.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = data.aws_lb_target_group.app.arn
    container_name = "ci-cd-app"
    container_port = 8000
  }
}
