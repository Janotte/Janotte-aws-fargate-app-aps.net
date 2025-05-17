output "dns_validation_records" {
  value = [
    for dvo in aws_acm_certificate.meusite_cert.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}

output "acm_certificate_arn" {  
  value = aws_acm_certificate.meusite_cert.arn
}