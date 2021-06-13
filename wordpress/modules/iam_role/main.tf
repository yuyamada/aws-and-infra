variable "config" {
  type = object({
    name       = string
    policy     = string
    identifier = string
  })
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [var.config.identifier]
    }
  }
}

resource "aws_iam_role" "default" {
  name               = var.config.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "default" {
  name   = var.config.name
  policy = var.config.policy
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}

output "arn" {
  value = aws_iam_role.default.arn
}

output "name" {
  value = aws_iam_role.default.name
}
