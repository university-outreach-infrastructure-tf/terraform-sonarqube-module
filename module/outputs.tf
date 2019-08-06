output "sg_sonarqube_internal_ssh_name" {
  value = aws_security_group.sonarqube_internal_ssh.name
}

output "sg_sonarqube_internal_ssh_ingress" {
  value = aws_security_group.sonarqube_internal_ssh.ingress
}

output "sg_sonarqube_external_ssh_name" {
  value = aws_security_group.sonarqube_external_ssh.name
}

output "sg_sonarqube_external_ssh_ingress" {
  value = aws_security_group.sonarqube_external_ssh.ingress
}

output "sg_sonarqube_alb_name" {
  value = aws_security_group.sonarqube_alb.name
}

output "sg_sonarqube_alb_ingress" {
  value = aws_security_group.sonarqube_alb.ingress
}

output "sg_internal_sonarqube_name" {
  value = aws_security_group.internal_sonarqube.name
}

output "sg_internal_sonarqube_ingress" {
  value = aws_security_group.internal_sonarqube.ingress
}

output "sonarqube_route53_sonarqube_alb" {
  value = aws_route53_record.sonarqube_alb_dns.fqdn
}

output "sonarqube_bastion_public_eip" {
  value = aws_eip.sonarqube_bastion.public_ip
}

output "sonarqube_private_ip" {
  value = aws_instance.sonarqube_application.private_ip
}
