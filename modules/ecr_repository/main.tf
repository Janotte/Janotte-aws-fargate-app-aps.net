resource "aws_ecr_repository" "ecr_repository" {
  name = "${var.repository_name}"

  tags = {
    Name        = "${var.repository_name}"
    Environment = var.environment
    Project     = var.project
  }
}