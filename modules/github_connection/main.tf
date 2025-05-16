# Criando a conexão com o GitHub
resource "aws_codestarconnections_connection" "github_connection" {
  name    = var.connection_name
  provider_type = var.github_provider
}