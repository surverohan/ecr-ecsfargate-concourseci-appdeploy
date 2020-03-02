provider "aws" { 
  region = "us-east-1"
  access_key = "AKIARD4KESXLKY4HA4WW"
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