locals {
  application_subnet_ids_by_az = values(zipmap(data.aws_subnet.application[*].availability_zone, data.aws_subnet.application[*].id))

  common_tags = {
    Environment    = var.environment
    Service        = var.service
    ServiceSubType = var.service_subtype
    Team           = var.team
  }

  common_resource_name = "${var.environment}-${var.service_subtype}"
  dns_zone             = "${var.environment}.${var.dns_zone_suffix}"

  security_s3_data            = data.vault_generic_secret.security_s3_buckets.data
  session_manager_bucket_name = local.security_s3_data.session-manager-bucket-name
  
  s3_shared_resources_data = data.vault_generic_secret.shared_services_s3_buckets.data
  shared_resources_bucket_name = local.s3_shared_resources_data.resources_bucket_name
  
  security_kms_keys_data = data.vault_generic_secret.security_kms_keys.data
  ssm_kms_key_id         = local.security_kms_keys_data.session-manager-kms-key-arn

  account_ids_secrets = jsondecode(data.vault_generic_secret.account_ids.data_json)
  chips_training_ami_owner_id = local.account_ids_secrets["heritage-staging"]

  aws_kms       = nonsensitive(data.vault_generic_secret.aws_kms_key.data)
  aws_kms_key   = local.aws_kms["ebs"]

  sns_email_secret = data.vault_generic_secret.sns_email.data
  linux_sns_email  = local.sns_email_secret["linux-email"]

  ami_owner = data.vault_generic_secret.ami_owner.data
  ami_owner_id = local.ami_owner["ami_owner"]

  public_key = jsondecode(nonsensitive(data.vault_generic_secret.public_key.data["training-db-envt25"]))
  training_db_envt25_public_key = base64decode(local.public_key["public_key"])


  root_disk_device = "nvme0n1p4"
  
  ebs_info = {
    ebs_u01 = {
      device = "mapper/vol.oracle.u01-lv.oracle_u01"
      path   = "u01"
    }
    ebs_u02 = {
      device = "mapper/vol.oracle.u02-lv.oracle_u02"
      path   = "/u02"
    }
  }
  
}
