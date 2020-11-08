data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "codebuild-packerTF-service-role"
  description        = "Managed by Terraform: AWS Service Role for the CodeBuild project named packerTF"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
}



/*
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
*/