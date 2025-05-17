variable "acm_certificate_arn" {
  description = "ARN do certificado SSL para o ALB"
  type        = string
}

variable "alb_arn" {
  description = "ARN do Application Load Balancer"
  type        = string  
}

variable "target_group_arn" {
  description = "ARN do Target Group"
  type        = string
}