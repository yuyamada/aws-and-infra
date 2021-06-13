data "aws_iam_policy_document" "s3_full_access" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

module "iam_role_wpadmin" {
  source = "./modules/iam_role"

  config = {
    name       = "wpadmin"
    policy     = data.aws_iam_policy_document.s3_full_access.json
    identifier = "ec2.amazonaws.com"
  }
}

resource "aws_iam_instance_profile" "wpadmin" {
  name = "wpadmin"
  role = module.iam_role_wpadmin.name
}
