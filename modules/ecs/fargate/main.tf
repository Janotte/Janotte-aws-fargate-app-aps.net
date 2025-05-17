resource "aws_ecs_cluster" "fargate" {
  name = var.fargate_name
}

resource "aws_ecs_cluster" "aspnet_cluster" {
  name = var.fargate_name
  tags = {
    Name        = var.fargate_name
    Project     = var.project
    Environment = var.environment
  }
}
