resource "aws_cloudwatch_metric_alarm" "chips_training_db_server_cpu95" {
  alarm_name                = "WARNING-chips-training-db-CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "CHIPS-TRAINING-DB/EC2"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.chips_training_db.arn]
  ok_actions                = [aws_sns_topic.chips_training_db.arn]
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_server_StatusCheckFailed" {
  alarm_name                = "CRITICAL-chips-training-db-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "CHIPS-TRAINING-DB/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.chips_training_db.arn]
  ok_actions                = [aws_sns_topic.chips_training_db.arn]
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_server_disk_space" {
  alarm_name          = "CRITICAL-chips-training-db-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CHIPS-TRAINING/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precetage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db.arn]
  ok_actions          = [aws_sns_topic.chips_training_db.arn]
  dimensions = {
    path         = "*"
  }
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_server_root_disk_space" {
  alarm_name          = "WARNING-chips-training-db-root-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CHIPS-TRAINING/EC2"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precetage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db.arn]
  ok_actions          = [aws_sns_topic.chips_training_db.arn]
  dimensions = {
    path         = "/"
  }
}
