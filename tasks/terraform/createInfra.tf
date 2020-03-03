provider "aws" { 
  region = "us-east-1"
  access_key = "AKIAQKMTZ5SKEJLTXHMH"
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

resource "aws_ecr_repository" "ecr_service" {
 name = "poctest"
}