resource "aws_security_group" "chips_training" {
  name        = local.common_resource_name
  description = "Security group for the ${var.service_subtype} EC2 instances"
  vpc_id      = data.aws_vpc.heritage.id

  tags = merge(local.common_tags, {
    Name = "${local.common_resource_name}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "chips_training_ssh" {
  description       = "Allow SSH connectivity for application deployments"
  security_group_id = aws_security_group.chips_training.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.shared_services_management.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "chips_training_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# OEM ingress rules

resource "aws_vpc_security_group_ingress_rule" "oem_admin_ssh" {
  description       = "Allow SSH connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_1521" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 1521
  to_port           = 1521
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_1522" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 1522
  to_port           = 1522
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_3872" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 3872
  to_port           = 3872
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_4903" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 4903
  to_port           = 4903
}

