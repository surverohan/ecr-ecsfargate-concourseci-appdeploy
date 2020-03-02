provider "aws" { 
  region = "us-east-1"
  access_key = "AKIATLJJ44EO2JP5EP7L"
  secret_key = "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"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "s3-graphql-bucket1"
  acl = "private"
  
  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
	prefix = "test-scripts"

    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days = 60
      storage_class = "GLACIER"
    }
  }
}