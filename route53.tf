# Define the provider
provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}

# Create a Route53 hosted zone
resource "aws_route53_zone" "example" {
  name = "example.com"  # Domain name for the hosted zone
}

# Create a record set for the hosted zone
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id  # Reference to the hosted zone
  name     = "www.example.com"  # Name of the record
  type     = "A"  # Record type
  ttl      = 300  # Time to live
  records   = ["192.0.2.1"]  # IP address for the record
}

# Create a record set for the root domain
resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.example.zone_id  # Reference to the hosted zone
  name     = "example.com"  # Name of the record
  type     = "A"  # Record type
  ttl      = 300  # Time to live
  records   = ["192.0.2.1"]  # IP address for the record
}
