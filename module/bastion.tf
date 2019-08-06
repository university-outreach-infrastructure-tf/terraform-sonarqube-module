resource "aws_instance" "sonarqube_bastion" {
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.public_selected1.id
  vpc_security_group_ids = [aws_security_group.sonarqube_external_ssh.id]
  key_name               = var.ssh_key_name
  ami                    = data.aws_ami.centos.id
  volume_tags            = { "Name" = format("%s-sonarqube-bastion-ebs", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
  tags                   = { "Name" = format("%s-sonarqube-bastion", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
}

resource "aws_eip" "sonarqube_bastion" {
  instance = aws_instance.sonarqube_bastion.id
  vpc      = true
  tags     = { "Name" = format("%s-sonarqube-bastion-eip", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
}
