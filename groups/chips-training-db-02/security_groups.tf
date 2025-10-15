resource "aws_security_group" "chips_training_db_02" {
  name        = local.common_resource_name
  description = "Security group for the ${var.service_subtype} EC2 instance"
  vpc_id      = data.aws_vpc.heritage.id

  tags = merge(local.common_tags, {
    Name = "${local.common_resource_name}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "chips_training_db_02_ssh" {
  description       = "Allow SSH connectivity for application deployments"
  security_group_id = aws_security_group.chips_training_db_02.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.shared_services_management.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "chips_training_db_02_admin_ssh" {
  description       = "Allow SSH connectivity from admin ranges"
  security_group_id = aws_security_group.chips_training_db_02.id
  prefix_list_id    = data.aws_ec2_managed_prefix_list.administration_cidr_ranges.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "chips_training_db_02_all_out" {
  description       = "Allow outbound traffic"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# OEM ingress rules

resource "aws_vpc_security_group_ingress_rule" "oem_admin_ssh" {
  description       = "Allow SSH connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_1521" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 1521
  to_port           = 1521
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_1522" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 1522
  to_port           = 1522
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_3872" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 3872
  to_port           = 3872
}

resource "aws_vpc_security_group_ingress_rule" "oem_admin_4903" {
  description       = "Allow connectivity from CHIPS OEM instances in heritage environments"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.oem_monitoring.data["oem-ip"]
  ip_protocol       = "tcp"
  from_port         = 4903
  to_port           = 4903
}

# Staffware RDS ingress

resource "aws_vpc_security_group_ingress_rule" "envt7_stf_rds_1521" {
  description       = "Allow connectivity from ENVT7 Staffware RDS"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.stf_rds.data["envt7swdb"]
  ip_protocol       = "tcp"
  from_port         = 1521
  to_port           = 1521
}

resource "aws_vpc_security_group_ingress_rule" "envt7_stf_rds_1522" {
  description       = "Allow connectivity from ENVT7 Staffware RDS"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.stf_rds.data["envt7swdb"]
  ip_protocol       = "tcp"
  from_port         = 1522
  to_port           = 1522
}

resource "aws_vpc_security_group_ingress_rule" "envt25_stf_rds_1521" {
  description       = "Allow connectivity from ENVT25 Staffware RDS"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.stf_rds.data["envt25swdb"]
  ip_protocol       = "tcp"
  from_port         = 1521
  to_port           = 1521
}

resource "aws_vpc_security_group_ingress_rule" "envt25_stf_rds_1522" {
  description       = "Allow connectivity from ENVT25 Staffware RDS"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.stf_rds.data["envt25swdb"]
  ip_protocol       = "tcp"
  from_port         = 1522
  to_port           = 1522
}

resource "aws_vpc_security_group_ingress_rule" "snapcenter_81XX" {
  count = var.snapcenter ? 1 : 0
    
  description       = "Allow connectivity from Netapp Snapcenter"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.netapp_snapcenter[0].data["ip"]
  ip_protocol       = "tcp"
  from_port         = 8145
  to_port           = 8146
}

resource "aws_vpc_security_group_ingress_rule" "snapcenter_22" {
  count = var.snapcenter ? 1 : 0
    
  description       = "Allow connectivity from Netapp Snapcenter"
  security_group_id = aws_security_group.chips_training_db_02.id
  cidr_ipv4         = data.vault_generic_secret.netapp_snapcenter[0].data["ip"]
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}
