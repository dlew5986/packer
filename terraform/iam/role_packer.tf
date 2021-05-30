data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole", "sts:TagSession"]
    principals {
      type        = "AWS"
      identifiers = [var.user_arn]
    }
  }
}

resource "aws_iam_role" "red_packer" {
  provider           = aws.red
  name               = "redPacker"
  description        = "packer description"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "red_packer" {
  provider   = aws.red
  role       = aws_iam_role.red_packer.name
  policy_arn = aws_iam_policy.policy_red_packer.arn
}

resource "aws_iam_role" "blue_packer" {
  provider           = aws.blue
  name               = "bluePacker"
  description        = "packer description"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "blue_packer" {
  provider   = aws.blue
  role       = aws_iam_role.blue_packer.name
  policy_arn = aws_iam_policy.policy_blue_packer.arn
}
