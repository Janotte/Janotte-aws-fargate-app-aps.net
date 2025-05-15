output "codestar_connection_arn" {
  description = "Conexão do AWS CodeStar"
  value = aws_codestarconnections_connection.github.arn
}