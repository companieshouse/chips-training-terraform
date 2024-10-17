resource "aws_instance" "chips_training" {
  count = var.instance_count

  ami           = data.aws_ami.oracle-12-ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour

  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.chips_training.id]
  tags = {
    Name           = "${local.common_resource_name}-${count.index + 1}"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team  
  }

  root_block_device {
    delete_on_termination = var.delete_on_termination
    volume_size           = var.root_volume_size
    volume_type           = var.volume_type
    encrypted             = var.ebs_encrypted
    kms_key_id            = local.ebs_kms_key_arn
    tags = {
      Name           = "${local.common_resource_name}-${count.index + 1}-root"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
    }
  }

  ebs_block_device {
    delete_on_termination = var.delete_on_termination
    device_name           = "/dev/xvdf"
    encrypted             = var.ebs_encrypted
    volume_size           = var.u01_storage_gb
    volume_type           = var.volume_type
    kms_key_id            = local.ebs_kms_key_arn
    tags = {
      Name           = "${local.common_resource_name}-${count.index + 1}-data"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
    }
  }
}
