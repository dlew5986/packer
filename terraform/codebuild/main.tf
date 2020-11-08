terraform {
  required_version = ">= 0.13, < 0.14"
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


resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_codebuild_project" "packer" {
  name         = "packerTF"
  description  = "Managed by Terraform: packer builder"
  service_role = aws_iam_role.role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    type                        = "LINUX_CONTAINER"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/dlew5986/packer-aws-ami"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "packerGroup"
      stream_name = "packerStream"
    }
  }

  tags = {
    project = "packer"
  }
}
