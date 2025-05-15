output "ecr_image_url" {
  description = "URL da imagem no ECR"
  value       = "${aws_ecr_repository.ecr_repository.repository_url}:latest"
}

output "ecr_repository_name" {
  description = "Nome do repositório ECR"
  value       = aws_ecr_repository.ecr_repository.name
}