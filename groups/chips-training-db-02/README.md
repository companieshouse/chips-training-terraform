# chips-training-02
Terraform for provisioning the CHIPS training environment.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.37.0, < 6.0.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.25.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.37.0, < 6.0.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 3.25.0, < 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| [instance_profile](#modules\_aws) | [git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.283](https://github.com/companieshouse/terraform-modules/tree/1.0.283/aws/instance_profile) | tags/1.0.283 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.chips_training](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route53_record.chips_training](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.chips_training](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_ingress_rule.chips_training_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_egress_rule.chips_training_all_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_ami.amzn2-base-ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ec2_managed_prefix_list.shared_services_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_subnet.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.heritage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [vault_generic_secret.account_ids](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.internal_cidrs](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_kms_keys](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.security_s3_buckets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_version_pattern"></a> [ami_version_pattern](#input\_ami_version_pattern) | The pattern to use when filtering for AMI version by name. | `string` | `"*"` | no |
| <a name="input_application_subnet_pattern"></a> [application_subnet_pattern](#input\_application_subnet_pattern) | The pattern to use when filtering for application subnets by 'Name' tag. | `string` | `"sub-application-*"` | no |
| <a name="input_aws_account"></a> [aws_account](#input\_aws_account) | The name of the AWS account (e.g., "heritage-development") | `string` | n/a | yes |
| <a name="input_default_log_retention_in_days"></a> [default_log_retention_in_days](#input\_default_log_retention_in_days) | The default log retention period in days to be used for CloudWatch log groups. | `number` | `7` | no |
| <a name="input_dns_zone_suffix"></a> [dns_zone_suffix](#input\_dns_zone_suffix) | The common DNS hosted zone suffix used across accounts. | `string` | `"heritage.aws.internal"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name (e.g., "development", "staging", "live") | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance_count](#input\_instance_count) | The number EC2 instances to create. | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance_type](#input\_instance_type) | The instance type to use for EC2 instances. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which resources will be created. | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root_volume_size](#input\_root_volume_size) | The size of the root volume in gibibytes (GiB). | `number` | `30` | no |
| <a name="input_service"></a> [service](#input\_service) | The service name to be used when creating AWS resources. | `string` | `"chips-e2e"` | no |
| <a name="input_service_subtype"></a> [service_subtype](#input\_service_subtype) | The service subtype name to be used when creating AWS resources. | `string` | `"chips-e2e-pilot"` | no |
| <a name="input_team"></a> [team](#input\_team) | The team name for ownership of this service. | `string` | `"Development"` | no |

### Vault Authentication Variables

Depending on the authentication method used for Vault, one of the following sets of variables will be required:

#### AppRole Authentication

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hashicorp_vault_role_id"></a> [hashicorp_vault_role_id](#input\_hashicorp_vault_role_id) | The role identifier used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_hashicorp_vault_secret_id"></a> [hashicorp_vault_secret_id](#input\_hashicorp_vault_secret_id) | The secret identifier used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |

#### UserPass Authentication

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hashicorp_vault_username"></a> [hashicorp_vault_username](#input\_hashicorp_vault_username) | The username used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |
| <a name="input_hashicorp_vault_password"></a> [hashicorp_vault_password](#input\_hashicorp_vault_password) | The password used when retrieving configuration from Hashicorp Vault | `string` | n/a | yes |

#### Token Authentication - **Deprecated**
 
This method is no longer in use, but used environment variables `VAULT_ADDR` and `VAULT_TOKEN`.

## Locals

| Name | Description |
|------|-------------|
| <a name="local_account_ids_secrets"></a> [account_ids_secrets](#local\_account_ids_secrets) | Account IDs retrieved from Vault |
| <a name="local_application_subnet_ids_by_az"></a> [application_subnet_ids_by_az](#local\_application_subnet_ids_by_az) | Map of availability zones to subnet IDs for application subnets |
| <a name="local_common_resource_name"></a> [common_resource_name](#local\_common_resource_name) | Common name format for resources |
| <a name="local_common_tags"></a> [common_tags](#local\_common_tags) | Common tags to be applied to all resources |
| <a name="local_dns_zone"></a> [dns_zone](#local\_dns_zone) | The DNS zone for the environment |
| <a name="local_chips_training_ami_owner_id"></a> [chips_training_ami_owner_id](#local\_chips_training_ami_owner_id) | CHIPS Pilot AMI Owner ID |
| <a name="local_security_kms_keys_data"></a> [security_kms_keys_data](#local\_security_kms_keys_data) | Security KMS keys data from Vault |
| <a name="local_security_s3_data"></a> [security_s3_data](#local\_security_s3_data) | Security S3 bucket data from Vault |
| <a name="local_session_manager_bucket_name"></a> [session_manager_bucket_name](#local\_session_manager_bucket_name) | Session Manager S3 bucket name |
| <a name="local_ssm_kms_key_id"></a> [ssm_kms_key_id](#local\_ssm_kms_key_id) | SSM KMS key ID |
