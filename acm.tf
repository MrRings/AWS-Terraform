# acm.tf

# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# Create an ACM certificate
resource "aws_acm_certificate" "example" {
  domain_name       = "example.com"
  validation_method = "DNS"

  # Tags for the certificate
  tags = {
    Name = "Example Certificate"
  }
}

# Create a DNS validation record
resource "aws_route53_record" "example_validation" {
  zone_id = "Z3M3LMZ3EXAMPLE" # Replace with your Route 53 zone ID
  name     = aws_acm_certificate.example.domain_validation_options[0].resource_record_name
  type     = aws_acm_certificate.example.domain_validation_options[0].resource_record_type
  ttl      = 60
  records  = [aws_acm_certificate.example.domain_validation_options[0].resource_record_value]
}

# Output the certificate ARN
output "certificate_arn" {
  value = aws_acm_certificate.example.arn
}
