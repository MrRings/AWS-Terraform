# Define the provider
provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"  # Unique name for the S3 bucket
  acl    = "private"  # Set the access control list to private

  # Enable versioning
  versioning {
    enabled = true  # Enable versioning for the bucket
  }

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"  # Use AES256 encryption
      }
    }
  }

  # Tags for the bucket
  tags = {
    Name        = "MyBucket"  # Name tag for the bucket
    Environment = "Dev"       # Environment tag
  }
}
