module "instance_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.283"
  name   = local.common_resource_name

  enable_ssm       = true
  kms_key_refs     = [local.ssm_kms_key_id]
  s3_buckets_write = [local.session_manager_bucket_name]
  s3_buckets_read  = [
                      local.session_manager_bucket_name,
                      local.shared_resources_bucket_name
                     ]

  custom_statements = [
    {
      sid       = "CloudWatchMetricsWrite"
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "cloudwatch:PutMetricData"
      ]
    },

    {
      sid       = "AllowDescribe",
      effect    = "Allow",
      resources = ["*"],
      actions = [
        "ec2:DescribeInstances",
        "ec2:DescribeTags"
      ]
    },

    {
      sid       = "AllowS3HighLevel",
      effect    = "Allow",
      resources = ["*"],
      actions = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ]
    }
  ]
}
