resource "aws_instance" "chips_training_01" {
  count = var.instance_count

  ami           = data.aws_ami.chips_training_ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour

  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.chips_training_01.id]
  tags = {
    Name           = local.common_resource_name
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
    Domain         = local.dns_zone
    Hostname       = var.service_subtype
  }

  root_block_device {
    volume_size = var.root_volume_size
    encrypted   = var.encrypt_root_block_device
    iops        = var.root_block_device_iops
    kms_key_id  = local.aws_kms_key
    throughput  = var.root_block_device_throughput
    volume_type = var.root_block_device_volume_type
    tags = {
      Name           = "${local.common_resource_name}-${count.index + 1}-root"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }

  }

  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_size           = var.data_volume_size_gib
    encrypted             = var.encrypt_ebs_block_device
    iops                  = var.ebs_block_device_iops
    kms_key_id            = local.aws_kms_key
    throughput            = var.ebs_block_device_throughput
    volume_type           = var.ebs_block_device_volume_type
    delete_on_termination = var.ebs_delete_on_termination
    tags = {
      Name           = "${local.common_resource_name}-ora1"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = false
    }
  }

  ebs_block_device {
    device_name           = var.ora2_device_name
    volume_size           = var.data_volume_size_gib
    encrypted             = var.encrypt_ebs_block_device
    iops                  = var.ebs_block_device_iops
    kms_key_id            = local.aws_kms_key
    throughput            = var.ebs_block_device_throughput
    volume_type           = var.ebs_block_device_volume_type
    delete_on_termination = var.ebs_delete_on_termination
    tags = {
      Name           = "${local.common_resource_name}-ora2"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }
  }

  ebs_block_device {
    device_name           = var.ora3_device_name
    volume_size           = var.ora_volume_size_gib
    encrypted             = var.encrypt_ebs_block_device
    iops                  = var.ebs_block_device_iops
    kms_key_id            = local.aws_kms_key
    throughput            = var.ebs_block_device_throughput
    volume_type           = var.ebs_block_device_volume_type
    delete_on_termination = var.ebs_delete_on_termination
    tags = {
      Name           = "${local.common_resource_name}-ora3"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }
  }

  ebs_block_device {
    device_name           = var.ora4_device_name
    volume_size           = var.ora_volume_size_gib
    encrypted             = var.encrypt_ebs_block_device
    iops                  = var.ebs_block_device_iops
    kms_key_id            = local.aws_kms_key
    throughput            = var.ebs_block_device_throughput
    volume_type           = var.ebs_block_device_volume_type
    delete_on_termination = var.ebs_delete_on_termination
    tags = {
      Name           = "${local.common_resource_name}-ora4"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }
  }

  ebs_block_device {
    device_name           = var.ora5_device_name
    volume_size           = var.ora_volume_size_gib
    encrypted             = var.encrypt_ebs_block_device
    iops                  = var.ebs_block_device_iops
    kms_key_id            = local.aws_kms_key
    throughput            = var.ebs_block_device_throughput
    volume_type           = var.ebs_block_device_volume_type
    delete_on_termination = var.ebs_delete_on_termination
    tags = {
      Name           = "${local.common_resource_name}-ora5"
      Environment    = var.environment
      Service        = var.service
      ServiceSubType = var.service_subtype
      Team           = var.team
      Backup         = true
    }
  }

}
#resource "aws_key_pair" "master" {
#  key_name   = "${local.common_resource_name}-master"
#  public_key = var.ssh_master_public_key
#}