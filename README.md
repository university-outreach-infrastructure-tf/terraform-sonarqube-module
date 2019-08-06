# terraform-sonarqube-module

This module assumes following resources are already available:

1. VPC
2. Public Subnet
3. Private Subnet
4. Route table, Route, Route Table Association for public subnet
5. Internet gateway for public subnet
6. Registered Domain Name
7. Route53 Hosted Zone
8. Certificate for Registered Domain Name

and it creates following resources:

1. SonarQube Instance
2. ALB for SonarQube
3. KMS Key for EBS encryption
4. Route53 entry for SonarQube
5. Security Groups
6. Bastion Host

Usage:

```
module "sonarqube" {
      source                            = "../module/"
      vpc_id                            = var.vpc_id
      namespace                         = "eg"
      name                              = "app"
      stage                             = "test"
      attributes                        = ["xyz"]
      private_subnet_id1                = var.private_subnet_id1
      private_subnet_id2                = var.private_subnet_id2
      public_subnet_id1                 = var.public_subnet_id1
      public_subnet_id2                 = var.public_subnet_id2
      dns_name                          = var.dns_name
      sonarqube_domain_name             = var.sonarqube_domain_name
      zone_id                           = var.zone_id
      ssh_key_name                      = var.ssh_key_name
      sonarqube_application_ami         = var.sonarqube_ami
      sonarqube_kms_alias               = var.sonarqube_kms_alias
}
```

## INPUT VALUES

| Input                      | Description                                                                                      | Type     | Default           | Required |
| -------------------------- | ------------------------------------------------------------------------------------------------ | -------- | ----------------- | -------- |
| namespace                  | Namespace, which could be your organization name or abbreviation"                                | `string` | ""                | yes      |
| stage                      | Stage, e.g. 'prod', 'staging', 'dev'                                                             | `string` | ""                | yes      |
| name                       | Solution name, e.g. 'app' or 'jenkins'                                                           | `string` | ""                | yes      |
| attributes                 | Additional attributes                                                                            | `list`   | `<list>`          | no       |
| delimiter                  | Delimiter to be used between namespace, environment, stage, name and attributes                  | `string` | "-"               | no       |
| domain_name                | ALB record53 entry domain name                                                                   | `string` | ""                | yes      |
| public_subnet_id1          | Public subnet ID to attach                                                                       | `string` | ""                | yes      |
| public_subnet_id2          | Public subnet ID to attach                                                                       | `string` | ""                | yes      |
| private_subnet_id1         | Private subnet ID to attach                                                                      | `string` | ""                | yes      |
| private_subnet_id2         | Private subnet ID to attach                                                                      | `string` | ""                | yes      |
| vpc_id                     | Id of the VPC Gitlab will be provisioned in                                                      | `string` | ""                | yes      |
| sonarqube_data_disk_size   | Size of sonarqube data disk to provision                                                         | `number` | `10`              | no       |
| sonarqube_data_device_name | Name of sonarqube data disk                                                                      | `string` | `/dev/xvdi`       | no       |
| sonarqube_data_directory   | Location of sonarqube data disk                                                                  | `string` | `/sonarqube-data` | no       |
| sonarqube_alb_idle_timeout | Time in seconds that the connection is allowed to be idle.                                       | `number` | `60`              | no       |
| sonarqube_application_ami  | AMI of SonarQube application to be used with SonarQube instance.                                 | `string` | ""                | yes      |
| zone_id                    | ID of the hosted zone to contain Route53 record.                                                 | `string` | ""                | yes      |
| sonarqube_kms_alias        | Display name of KMS Key alias. Name must start with the word `alias` followed by a forward slash | `string` | ""                | yes      |
| enable_key_rotation        | Specifies whether key rotation is enabled                                                        | `bool`   | `true`            | no       |
| ssh_key_name               | SSH key for ec2 ssh                                                                              | `string` | ""                | yes      |

## OUTPUT VALUE NAMES

| Name                              | Description                                         |
| --------------------------------- | --------------------------------------------------- |
| sg_sonarqube_internal_ssh_name    | Security Group name for sonarqube internal SSH      |
| sg_sonarqube_internal_ssh_ingress | Security Group ingress Rules sonarqube internal SSH |
| sg_sonarqube_external_ssh_name    | Security Group name for sonarqube bastion           |
| sg_sonarqube_external_ssh_ingress | Security Group ingress rules for sonarqube bastion  |
| sg_sonarqube_alb_name             | Security Group name for sonarqube ALB               |
| sg_sonarqube_alb_ingress          | Security Group ingress rules sonarqube ALB          |
| sg_internal_sonarqube_name        | Security Group name for sonarqube instance          |
| sg_internal_sonarqube_ingress     | Security Group ingress rules sonarqube instance     |
| sonarqube_acm_cert_arn            | SonarQube ACM Certificate ARN                       |
| sonarqube_route53_cert_validation | SonarQube ALB Route53 FQDN                          |
| sonarqube_route53_sonarqube_alb   | Route53 FQDN for SonarQube instance                 |
| sonarqube_bastion_public_eip      | EIP Address of SonarQube Bastion Instance           |
| sonarqube_private_ip              | Private IP Address of Gitlab Instance               |
