resource "aws_instance" "training_db_fes25" {
  count = var.instance_count

  ami           = data.aws_ami.chips_training_ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour
  key_name      = aws_key_pair.training_db_fes25.key_name
  
  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.training_db_fes25.id]
  tags = {
    Name           = local.common_resource_name
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
    Zone           = local.dns_zone
    Hostname       = var.service_subtype
    ENVTs          = var.db_env
    Repository     = var.origin
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
}

resource "aws_ebs_volume" "ora1" {
  availability_zone = aws_instance.training_db_fes25[0].availability_zone
  size              = var.ora_volume_size_gib
  encrypted         = var.encrypt_ebs_block_device
  iops              = var.ebs_block_device_iops
  kms_key_id        = local.aws_kms_key
  throughput        = var.ebs_block_device_throughput
  type              = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-ora1"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "ora1_att" {
  device_name = var.ora1_device_name
  volume_id   = aws_ebs_volume.ora1.id
  instance_id = aws_instance.training_db_fes25[0].id
}


resource "aws_ebs_volume" "ora2" {
  availability_zone = aws_instance.training_db_fes25[0].availability_zone
  size              = var.ora_volume_size_gib
  encrypted         = var.encrypt_ebs_block_device
  iops              = var.ebs_block_device_iops
  kms_key_id        = local.aws_kms_key
  throughput        = var.ebs_block_device_throughput
  type              = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-ora2"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "ora2_att" {
  device_name = var.ora2_device_name
  volume_id = aws_ebs_volume.ora2.id
  instance_id = aws_instance.training_db_fes25[0].id
}


resource "aws_ebs_volume" "ora_crs1" {
  availability_zone = aws_instance.training_db_fes25[0].availability_zone
  size              = var.crs_volume_size_gib
  encrypted         = var.encrypt_ebs_block_device
  iops              = var.ebs_block_device_iops
  kms_key_id        = local.aws_kms_key
  throughput        = var.ebs_block_device_throughput
  type              = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-ora_crs1"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "ora_crs1_att" {
  device_name = var.ora3_device_name
  volume_id = aws_ebs_volume.ora_crs1.id
  instance_id = aws_instance.training_db_fes25[0].id
}

resource "aws_ebs_volume" "ora_crs2" {
  availability_zone = aws_instance.training_db_fes25[0].availability_zone
  size              = var.crs_volume_size_gib
  encrypted         = var.encrypt_ebs_block_device
  iops              = var.ebs_block_device_iops
  kms_key_id        = local.aws_kms_key
  throughput        = var.ebs_block_device_throughput
  type              = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-ora_crs2"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "ora_crs2_att" {
  device_name = var.ora4_device_name
  volume_id = aws_ebs_volume.ora_crs2.id
  instance_id = aws_instance.training_db_fes25[0].id
}

resource "aws_ebs_volume" "ora_crs3" {
  availability_zone = aws_instance.training_db_fes25[0].availability_zone
  size              = var.crs_volume_size_gib
  encrypted         = var.encrypt_ebs_block_device
  iops              = var.ebs_block_device_iops
  kms_key_id        = local.aws_kms_key
  throughput        = var.ebs_block_device_throughput
  type              = var.ebs_block_device_volume_type
  tags = {
    Name           = "${local.common_resource_name}-ora_crs3"
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
    Backup         = true
  }
}

resource "aws_volume_attachment" "ora_crs3_att" {
  device_name = var.ora5_device_name
  volume_id = aws_ebs_volume.ora_crs3.id
  instance_id = aws_instance.training_db_fes25[0].id
}

resource "aws_key_pair" "training_db_fes25" {
 key_name   = "${local.common_resource_name}-public-key"
 public_key = local.training_db_fes25_public_key
}
