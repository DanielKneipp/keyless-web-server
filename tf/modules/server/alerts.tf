resource "aws_cloudwatch_metric_alarm" "cpu_usage" {
  alarm_name          = "server-cpu-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    InstanceId = aws_instance.server.id
  }
}

resource "aws_cloudwatch_metric_alarm" "ram_usage" {
  alarm_name          = "server-ram-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    InstanceId   = aws_instance.server.id
    ImageId      = var.ami
    InstanceType = "t2.micro"
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_usage" {
  alarm_name          = "server-disk-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"

  dimensions = {
    InstanceId   = aws_instance.server.id
    device       = "xvda1"
    path         = "/"
    fstype       = "xfs"
    ImageId      = var.ami
    InstanceType = "t2.micro"
  }
}
