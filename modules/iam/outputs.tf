output "codebuild_role_arn" {
  description = "ARN da Role do CodeBuild"
  value       = aws_iam_role.codebuild_access_role.arn
}

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}