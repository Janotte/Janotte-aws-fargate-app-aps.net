resource "aws_cloudwatch_metric_alarm" "alb_5xx_alarm" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    LoadBalancer = var.alb_name
  }

  alarm_description = var.alarm_description
  treat_missing_data = "notBreaching"
}
