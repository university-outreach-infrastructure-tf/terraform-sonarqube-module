resource "aws_kms_key" "sonarqube_kms_key" {
  description             = "SonarQube KMS key"
  deletion_window_in_days = 10
  tags                    = module.sonarqube_label.tags
  enable_key_rotation     = var.enable_key_rotation
}

resource "aws_kms_alias" "sonarqube_kms_key_alias" {
  name          = coalesce(var.sonarqube_kms_alias, format("alias/%v", module.sonarqube_label.id))
  target_key_id = aws_kms_key.sonarqube_kms_key.key_id
}
