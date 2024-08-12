resource "aws_instance" "chips_training" {
  count = var.instance_count

  ami           = data.aws_ami.rhel8-base-ami.id
  instance_type = var.instance_type
  subnet_id     = element(local.application_subnet_ids_by_az, count.index) # use 'element' function for wrap-around behaviour

  iam_instance_profile   = module.instance_profile.aws_iam_instance_profile.name
  vpc_security_group_ids = [aws_security_group.chips_training.id]

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = merge(local.common_tags, {
    Name = "${local.common_resource_name}-${count.index + 1}"
  })
  volume_tags = local.common_tags
}
