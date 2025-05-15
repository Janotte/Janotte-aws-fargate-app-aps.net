resource "aws_codebuild_project" "codebuild" {
  name          = var.codebuild_name
  description   = "Build do app .NET com origem GitHub e artefato em S3"
  service_role  = var.codebuild_role_arn
  build_timeout = 10
  
  source {
    type = "GITHUB"
    location = "https://github.com/${var.github_owner}/${var.github_repo}"
  
    auth {
      type     = "OAUTH"
      resource = var.codestar_connection_arn
    }
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }

  artifacts {
    type      = "S3"
    location  = var.artifact_bucket 
    path      = var.artifact_path
    name      = "build-output.zip"
    packaging = "ZIP"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:6.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = "PLAINTEXT"
      }
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/codebuild/${var.project}"
      stream_name = "${var.project}-build"
    }
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

