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

data "aws_ami" "rhel8-base-ami" {
  most_recent = true
  name_regex  = "rhel8-base-\\d.\\d.\\d"

  filter {
    name   = "name"
    values = ["rhel8-base-${var.ami_version_pattern}"]
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
