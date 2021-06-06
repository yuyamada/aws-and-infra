data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_full_access" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy" "s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role" "wpadmin" {
  name               = "aws-and-infra-wpadmin"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_s3_full_access" {
  role       = aws_iam_role.wpadmin.name
  policy_arn = data.aws_iam_policy.s3_full_access.arn
}

resource "aws_iam_instance_profile" "wpadmin" {
  name = "aws-and-infra-wpadmin"
  role = aws_iam_role.wpadmin.name
}
