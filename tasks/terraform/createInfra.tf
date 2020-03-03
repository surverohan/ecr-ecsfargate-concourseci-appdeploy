provider "aws" { 
  region = "us-east-1"
  access_key = "AKIA5A6WR4FYPY2ATB4F"
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