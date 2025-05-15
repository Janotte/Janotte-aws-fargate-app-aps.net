output "vpc_id" {
  description = "Nome da VPC"
  value       = aws_vpc.main.id
}
output "public_subnet_a_id" {
  description = "ID da Sub-rede Pública A"
  value       = aws_subnet.public_subnet_a.id
}
output "public_subnet_b_id" {
  description = "ID da Sub-rede Pública B"
  value       = aws_subnet.public_subnet_b.id
}
output "private_subnet_a_id" {
  description = "ID da Sub-rede Privada A"
  value       = aws_subnet.private_subnet_a.id
}
output "private_subnet_b_id" {
  description = "ID da Sub-rede Privada B"
  value       = aws_subnet.private_subnet_b.id
}
