resource "aws_ebs_volume" "sonarqube_data" {
  size              = var.sonarqube_data_disk_size
  kms_key_id        = aws_kms_key.sonarqube_kms_key.arn
  encrypted         = true
  type              = "gp2"
  availability_zone = data.aws_subnet.private_selected1.availability_zone
  tags              = { "Name" = format("%s-sonarqube-data-disk", module.sonarqube_label.name), "Type" = "sonarqube-data" }
}

resource "aws_volume_attachment" "sonarqube_data_attachment" {
  device_name  = var.sonarqube_data_device_name
  volume_id    = aws_ebs_volume.sonarqube_data.id
  instance_id  = aws_instance.sonarqube_application.id
  force_detach = true
}
