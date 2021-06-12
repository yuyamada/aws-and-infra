resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"
  alarm_description   = "moniter ec2 cpu utilization"
  alarm_actions       = [aws_sns_topic.cpu.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }
}

resource "aws_cloudwatch_metric_alarm" "http5xx" {
  alarm_name          = "http5xx"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "120"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "moniter http status 5xx count"
  alarm_actions       = [aws_sns_topic.http5xx.arn]

  dimensions = {
    LoadBalancer = aws_lb.aws_and_infra.arn_suffix
  }
}
