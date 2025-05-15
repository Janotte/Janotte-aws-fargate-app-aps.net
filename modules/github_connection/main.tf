resource "aws_codestarconnections_connection" "github" {
  name          = var.connection_name
  provider_type = var.provider_type
}