resource "aws_s3_bucket" "s3_artifacts" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_s3_bucket_versioning" "s3_artifacts" {
  bucket = aws_s3_bucket.s3_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}