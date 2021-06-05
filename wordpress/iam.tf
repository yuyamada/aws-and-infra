resource "aws_iam_user" "wp_admin" {
  name = "aws-and-infra-wpadmin"
}

resource "aws_iam_user_policy_attachment" "wp_admin_s3_full_access" {
  user       = aws_iam_user.wp_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "wp_admin" {
  user = aws_iam_user.wp_admin.name
}
