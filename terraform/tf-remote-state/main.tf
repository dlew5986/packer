terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

data "aws_kms_key" "s3_kms_key" {
  key_id = "alias/aws/s3"
}

resource "aws_s3_bucket" "tf_state_packer_aws_ami" {
  bucket = "tf-state-packer-aws-ami"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.s3_kms_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_packer_aws_ami_public_access" {
  bucket = aws_s3_bucket.tf_state_packer_aws_ami.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_state_packer_aws_ami_locks" {
  name         = "tf-state-packer-aws-ami-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
