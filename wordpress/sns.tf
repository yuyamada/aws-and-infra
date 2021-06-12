resource "aws_sns_topic" "cpu" {
  name = "cpu"
}

resource "aws_sns_topic_subscription" "cpu" {
  topic_arn = aws_sns_topic.cpu.arn
  protocol  = "email"
  endpoint  = "ya4ma1da3@gmail.com"
}

resource "aws_sns_topic" "http5xx" {
  name = "cpu"
}

resource "aws_sns_topic_subscription" "http5xx" {
  topic_arn = aws_sns_topic.cpu.arn
  protocol  = "email"
  endpoint  = "ya4ma1da3@gmail.com"
}
