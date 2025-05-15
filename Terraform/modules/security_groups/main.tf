
# Security Group para os containers
resource "aws_security_group" "containers_sg" {
  name        = "${var.security_group_name}"
  description = "Grupo de seguranca para Containers"
  vpc_id      = var.vpc_id
  tags = {
    Name        =  "${var.security_group_name}"
    Project     = var.project
    Environment = var.environment
  }

  ingress {
    description = "Libera trafego HTTP de entrada de qualquer origem"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Libera trafego HTTPS de entrada de qualquer origem"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Libera trafego SSH de entrada de qualquer origem"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Libera todo trafego de saida para qualquer destino"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}