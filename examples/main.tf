provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "sonarqube" {
  source                    = "../module/"
  vpc_id                    = var.vpc_id
  namespace                 = "eg"
  name                      = "app"
  stage                     = "test"
  attributes                = ["xyz"]
  private_subnet_id1        = var.private_subnet_id1
  private_subnet_id2        = var.private_subnet_id2
  public_subnet_id1         = var.public_subnet_id1
  public_subnet_id2         = var.public_subnet_id2
  dns_name                  = var.dns_name
  sonarqube_domain_name     = var.sonarqube_domain_name
  zone_id                   = var.zone_id
  ssh_key_name              = var.ssh_key_name
  sonarqube_application_ami = var.sonarqube_ami
  sonarqube_kms_alias       = var.sonarqube_kms_alias
}
