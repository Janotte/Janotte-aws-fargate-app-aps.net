# Role para CodeBuild
resource "aws_iam_role" "codebuild_access_role" {
  name               = var.codebuild_role_name
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json
}

data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "codebuild_inline_policy" {
  name = var.codebuild_policy_name
  role = aws_iam_role.codebuild_access_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "s3:*",
          "ecr:*",
          "codebuild:*"
        ],
        Resource = "*"
      }
    ]
  })
}