variable "aws_account" {
  type        = string
  description = "The name of the AWS account in which resources will be provisioned."
}

variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be created."
}

variable "environment" {
  type        = string
  description = "The environment name to be used when provisioning AWS resources."
}

variable "ami_version_pattern" {
  type        = string
  description = "The pattern to use when filtering for AMI version by name."
  default     = "*"
}

variable "instance_count" {
  type        = number
  description = "The number EC2 instances to create."
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "The instance type to use for EC2 instances."
  default     = "t3.small"
}

variable "application_subnet_pattern" {
  type        = string
  description = "The pattern to use when filtering for application subnets by 'Name' tag."
}

variable "dns_zone_suffix" {
  type        = string
  description = "The common DNS hosted zone suffix used across accounts."
  default     = "staging.aws.internal"
}

variable "default_log_retention_in_days" {
  type        = number
  description = "The default log retention period in days to be used for CloudWatch log groups."
}

variable "service" {
  type        = string
  description = "The service name to be used when creating AWS resources."
  default     = ""
}

variable "service_subtype" {
  type        = string
  description = "The service subtype name to be used when creating AWS resources."
}

variable "team" {
  type        = string
  description = "The team name for ownership of this service."
  default     = "Linux & Storage"
}

variable "oem_monitor" {
  type        = bool
  description = "A boolean value indicating whether to enable OEM monitor or not"
  default     = false
}

variable "snapcenter" {
  type        = bool
  default     = false
  description = "Defines whether SnapCenter is used by the instance"
}

variable "db_env" {
  type        = string
  description = "List of DB environment names"
}

variable "origin" {
  type        = string
  description = "Github Repository where instance code resides"
  default     = ""
}

# Disk variables
# ----------------------------------------------------------------------

variable "disk_fs_type" {
  default     = "xfs"
  description = "Default filesytem type for root/ebs block devices"
  type        = string
}

variable "root_disk_attachment" {
  default     = "/"
  description = "Filesystem attachment point for root disk"
  type        = string
}
variable "root_volume_size" {
  type        = number
  description = "The size of the root volume in gibibytes (GiB)."
  default     = 20
}

variable "encrypt_root_block_device" {
  default     = true
  description = "Defines whether the EBS volume should be encrypted with the cluster's KMS key"
  type        = bool
}

variable "root_block_device_iops" {
  default     = 3000
  description = "The required IOPS on the EBS volume; 3000 is the gp3 default"
  type        = number
}

variable "root_block_device_throughput" {
  default     = 250
  description = "The required EBS volume throughput in MiB/s; 125 is the gp3 default"
  type        = number
}

variable "root_block_device_volume_type" {
  default     = "gp3"
  description = "The type of EBS volume to provision"
  type        = string
}
# ----------------------------------------------------------------------
variable "encrypt_ebs_block_device" {
  default     = true
  description = "Defines whether the EBS volume should be encrypted with the cluster's KMS key"
  type        = bool
}

variable "ebs_delete_on_termination" {
  default     = true
  description = "Defines whether the EBS volume should be deleted on terination"
  type        = bool
}
variable "ebs_block_device_iops" {
  default     = 3000
  description = "The required IOPS on the EBS volume; 3000 is the gp3 default"
  type        = number
}

variable "ebs_block_device_throughput" {
  default     = 250
  description = "The required EBS volume throughput in MiB/s; 125 is the gp3 default"
  type        = number
}

variable "ebs_block_device_volume_type" {
  default     = "gp3"
  description = "The type of EBS volume to provision"
  type        = string
}
# ----------------------------------------------------------------------
variable "ora_volume_size_gib" {
  type        = number
  default     = 20
  description = "The EC2 instance data volume size in Gibibytes (GiB)"
}

variable "crs_volume_size_gib" {
  type        = number
  default     = 5
  description = "The EC2 instance data volume size in Gibibytes (GiB)"
}
# ----------------------------------------------------------------------
variable "ora1_device_name" {
  default     = "/dev/xvdc"
  description = "The device name for the ebs device"
  type        = string
}

variable "ora2_device_name" {
  default     = "/dev/xvdd"
  description = "The device name for the ebs device"
  type        = string
}

variable "ora3_device_name" {
  default     = "/dev/xvde"
  description = "The device name for the ebs device"
  type        = string
}

variable "ora4_device_name" {
  default     = "/dev/xvdf"
  description = "The device name for the ebs device"
  type        = string
}

variable "ora5_device_name" {
  default     = "/dev/xvdg"
  description = "The device name for the ebs device"
  type        = string
}
# ----------------------------------------------------------------------
variable "monitoring" {
  description = "Boolean to enable/disable monitoring"
  default     = false
  type        = bool
}
