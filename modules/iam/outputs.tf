output "codebuild_role_arn" {
  description = "ARN da Role do CodeBuild"
  value       = aws_iam_role.codebuild_access_role.arn
}