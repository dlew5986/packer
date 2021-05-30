terraform {
  backend "s3" {
    bucket         = "tf-state-packer-aws-ami"
    dynamodb_table = "tf-state-packer-aws-ami-locks"
    encrypt        = true
    key            = "iam/terraform.tfstate"
    region         = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "red"
  region = "us-east-2"

  assume_role {
    role_arn = var.assume_role_arn_red
  }
}

provider "aws" {
  alias  = "blue"
  region = "us-east-2"

  assume_role {
    role_arn = var.assume_role_arn_blue
  }
}
