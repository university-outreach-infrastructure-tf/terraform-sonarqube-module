variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  default     = ""
}

variable "attributes" {
  type        = list
  description = "Additional attributes (e.g. 1)"
  default     = []
}

variable "delimiter" {
  type        = string
  description = "Delimiter to be used between namespace, environment, stage, name and attributes"
  default     = "-"
}

variable "name" {
  type        = "string"
  description = "A prefix to add to project resources"
  default     = ""
}

variable "dns_name" {
  type        = string
  description = "AWS account cert dns address"
  default     = ""
}

variable "sonarqube_domain_name" {
  type        = string
  description = "ALB record53 entry for the SonarQube domain name"
  default     = ""
}

variable "public_subnet_id1" {
  type        = string
  description = "Public subnet ID to attach"
}

variable "public_subnet_id2" {
  type        = string
  description = "Public subnet ID to attach"
}

variable "private_subnet_id1" {
  type        = string
  description = "Private subnet ID to attach"
}

variable "private_subnet_id2" {
  type        = string
  description = "Private subnet ID to attach"
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC sonarqube will be provisioned in."
  default     = ""
}

variable "sonarqube_data_disk_size" {
  description = "The size of sonarqube data disk to provision"
  default     = 10
}

variable "sonarqube_data_device_name" {
  type        = string
  description = "The name sonarqube data disk"
  default     = "/dev/xvdb"
}

variable "sonarqube_data_directory" {
  type    = string
  default = "/sonarqube-data"
}

variable "sonarqube_alb_idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = 60
}

variable "sonarqube_application_ami" {
  type        = string
  description = "AMI of SonarQube application to be used with SonarQube instance. AMI can be built using Packer like: https://github.com/university-outreach-infrastructure-tf/sonarqube-packer-ami"
  default     = ""
}

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain Route53 record."
  default     = ""
}

variable "sonarqube_kms_alias" {
  type        = string
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash"
  default     = ""
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  default     = true
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key for ec2 ssh"
  default     = ""
}
