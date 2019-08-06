resource "aws_instance" "sonarqube_application" {
  ami                         = var.sonarqube_application_ami
  instance_type               = "t2.xlarge"
  subnet_id                   = data.aws_subnet.private_selected1.id
  vpc_security_group_ids      = flatten([aws_security_group.sonarqube_internal_ssh.id, aws_security_group.internal_sonarqube.id])
  key_name                    = var.ssh_key_name
  user_data                   = data.template_cloudinit_config.config.rendered
  associate_public_ip_address = false
  monitoring                  = true
  volume_tags                 = { "Name" = format("%s-sonarqube-instance-ebs", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
  tags                        = { "Name" = format("%s-sonarqube-instance", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
}
