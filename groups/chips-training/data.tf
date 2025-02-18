data "aws_ec2_managed_prefix_list" "shared_services_management" {
  name = "shared-services-management-cidrs"
}

data "aws_route53_zone" "private_zone" {
  name   = local.dns_zone
  vpc_id = data.aws_vpc.heritage.id
}

data "aws_vpc" "heritage" {
  filter {
    name   = "tag:Name"
    values = ["vpc-heritage-${var.environment}"]
  }
}

data "vault_generic_secret" "internal_cidrs" {
  path = "aws-accounts/network/internal_cidr_ranges"
}

data "aws_subnets" "application" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.heritage.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.application_subnet_pattern]
  }
}

data "aws_subnet" "application" {
  count = length(data.aws_subnets.application.ids)
  id    = tolist(data.aws_subnets.application.ids)[count.index]
}

data "vault_generic_secret" "ami_owner" {
  path = "/applications/${var.aws_account}-${var.aws_region}/chips-training"
}

data "aws_ami" "chips-training-ami" {
  most_recent = true
  name_regex  = "chips-training-ami-\\d.\\d.\\d"

  filter {
    name   = "name"
    values = ["chips-training-ami-${var.ami_version_pattern}"]
  }

  filter {
    name  = "owner-id"
    values = ["${local.ami_owner_id}"]
  }
}

data "vault_generic_secret" "account_ids" {
  path = "aws-accounts/account-ids"
}

data "vault_generic_secret" "kms_keys" {
  path = "aws-accounts/${var.aws_account}/kms"
}

data "vault_generic_secret" "security_s3_buckets" {
  path = "aws-accounts/security/s3"
}

data "vault_generic_secret" "security_kms_keys" {
  path = "aws-accounts/security/kms"
}

data "vault_generic_secret" "oem_monitoring" {
  path  = "/applications/${var.aws_account}-${var.aws_region}/chips-training"
}

data "vault_generic_secret" "stf_rds" {
  path  = "/applications/${var.aws_account}-${var.aws_region}/chips-training"
}

data "vault_generic_secret" "iscsi_init" {
  path  = "/applications/${var.aws_account}-${var.aws_region}/chips-training"
}

data "vault_generic_secret" "sns_email" {
  path = "/applications/${var.aws_account}-${var.aws_region}/monitoring"
}

data "vault_generic_secret" "sns_url" {
  path = "/applications/${var.aws_account}-${var.aws_region}/monitoring"
}

data "template_file" "userdata" {
  template = file("${path.module}/templates/user_data.tpl")

  count = var.instance_count

  vars = { 
    ENVIRONMENT          = title(var.environment)
    APPLICATION_NAME     = var.service_subtype
    ANSIBLE_INPUTS       = jsonencode(merge(local.ansible_inputs, { hostname = format("%s-%02d", var.service_subtype, count.index + 1) }))
    ISCSI_INITIATOR_NAME = local.iscsi_initiator_names[count.index]
  }
}
