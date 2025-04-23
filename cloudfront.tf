# cloudfront.tf

# Define the CloudFront distribution
resource "aws_cloudfront_distribution" "example" {
  origin {
    domain_name = "example.com"
    origin_id   = "exampleOrigin"
    
    # Specify the origin path
    origin_path = "/path"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Example CloudFront Distribution"
  default_root_object = "index.html"

  # Default cache behavior
  default_cache_behavior {
    target_origin_id = "exampleOrigin"
    
    # Viewer protocol policy
    viewer_protocol_policy = "redirect-to-https"
    
    # Allowed HTTP methods
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    
    # Cached HTTP methods
    cached_methods = ["GET", "HEAD"]
    
    # Forward cookies
    forward_cookies = "none"
    
    # Forward query strings
    forward_query_string = false
  }

  # Price class
  price_class = "PriceClass_All"

  # Viewer certificate
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # Restrict viewer access
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Logging configuration
  logging_config {
    bucket         = "my-logs.s3.amazonaws.com"
    include_cookies = false
    prefix         = "cloudfront/"
  }
}
