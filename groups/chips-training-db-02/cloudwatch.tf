resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_StatusCheckFailed" {
  alarm_name                = "${upper(var.environment)} - CRITICAL - chips-training-db-02-StatusCheckFailed"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "This metric monitors StatusCheckFailed"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions                = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    instance_id = aws_instance.chips_training_db_02[0].id
  }
}
# --------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_cpu95" {
  alarm_name                = "${upper(var.environment)} - CRITICAL - chips-training-db-02 - CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "95"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions                = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    instance_id = aws_instance.chips_training_db_02[0].id
  }
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_cpu75" {
  alarm_name                = "${upper(var.environment)} - WARNING - chips-training-db-02 - CPUUtilization"
  evaluation_periods        = "1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "75"
  alarm_description         = "This metric monitors ec2 cpu utilization system"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions                = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    instance_id = aws_instance.chips_training_db_02[0].id
  }
}

# --------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_root_disk_space_crit" {
  alarm_name          = "${upper(var.environment)} - CRITICAL - chips-training-db-02 - root-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precentage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = var.root_disk_attachment
    device            = local.root_disk_device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_root_disk_space_warn" {
  alarm_name          = "${upper(var.environment)} - WARNING - chips-training-db-02 - root-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precentage is over 80% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = var.root_disk_attachment
    device            = local.root_disk_device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

# --------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_u01_space_crit" {
  alarm_name          = "${upper(var.environment)} - CRITICAL - chips-training-db-02 - /u01-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precentage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = local.ebs_info.ebs_u01.path
    device            = local.ebs_info.ebs_u01.device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_u01_space_warn" {
  alarm_name          = "${upper(var.environment)} - WARNING - chips-training-db-02 - /u01-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precentage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = local.ebs_info.ebs_u01.path
    device            = local.ebs_info.ebs_u01.device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

# --------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_u02_disk_space_crit" {
  alarm_name          = "${upper(var.environment)} - CRITICAL - chips-training-db-02 - /u02-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "The disk space average precentage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = local.ebs_info.ebs_u01.path
    device            = local.ebs_info.ebs_u01.device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_u02_disk_space_warn" {
  alarm_name          = "${upper(var.environment)} - WARNING - chips-training-db-02 - /u02-disk-space"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "600"
  evaluation_periods  = "1"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "The disk space average precentage is over 90% for the last 10 minutes"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]
  dimensions = {
    path              = local.ebs_info.ebs_u02.path
    device            = local.ebs_info.ebs_u02.device
    fstype            = var.disk_fs_type
    InstanceId        = aws_instance.chips_training_db_02[0].id
    ImageId           = data.aws_ami.chips_training_ami.id
    InstanceType      = var.instance_type
  }
}

# --------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_vtx_root" {

  alarm_name          = "${upper(var.environment)} - WARNING - chips-training-db-02 - EBS Throughput Exceeded (root)"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "VolumeThroughputExceededCheck"
  namespace           = "AWS/EBS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Throughput exceeded for root volume"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]

  dimensions = {
    VolumeId = aws_instance.chips_training_db_02[0].root_block_device[0].volume_id
    InstanceId = aws_instance.chips_training_db_02[0].id
    } 
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_vtx_ora1" {

  alarm_name          = "${upper(var.environment)} - WARNING - chips-training-db-02 - EBS Throughput Exceeded (u01)"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "VolumeThroughputExceededCheck"
  namespace           = "AWS/EBS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Throughput exceeded for volume ora1"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]

  dimensions = {
    VolumeId = aws_ebs_volume.ora1.id
    InstanceId = aws_instance.chips_training_db_02[0].id
    } 
}

resource "aws_cloudwatch_metric_alarm" "chips_training_db_02_vtx_ora2" {

  alarm_name          = "${upper(var.environment)} - WARMING - chips-training-db-02 - EBS Throughput Exceeded (u02)"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "VolumeThroughputExceededCheck"
  namespace           = "AWS/EBS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Throughput exceeded for volume ora2"
  alarm_actions       = [aws_sns_topic.chips_training_db_02.arn]
  ok_actions          = [aws_sns_topic.chips_training_db_02.arn]

  dimensions = {
    VolumeId = aws_ebs_volume.ora2.id
    InstanceId = aws_instance.chips_training_db_02[0].id
    } 
}
