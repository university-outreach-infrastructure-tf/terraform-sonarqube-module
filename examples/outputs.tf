output "sg_internal_ssh_name" {
  value = module.sonarqube.sg_sonarqube_internal_ssh_name
}

output "sg_internal_ssh_ingress" {
  value = module.sonarqube.sg_sonarqube_internal_ssh_ingress
}

output "sg_external_ssh_name" {
  value = module.sonarqube.sg_sonarqube_external_ssh_name
}

output "sg_external_ssh_ingress" {
  value = module.sonarqube.sg_sonarqube_external_ssh_ingress
}

output "sg_sonarqube_alb_name" {
  value = module.sonarqube.sg_sonarqube_alb_name
}

output "sg_sonarqube_alb_ingress" {
  value = module.sonarqube.sg_sonarqube_alb_ingress
}

output "sg_internal_sonarqube_name" {
  value = module.sonarqube.sg_internal_sonarqube_name
}

output "sg_internal_sonarqube_ingress" {
  value = module.sonarqube.sg_internal_sonarqube_ingress
}

output "sonarqube_route53_sonarqube_alb" {
  value = module.sonarqube.sonarqube_route53_sonarqube_alb
}

output "sonarqube_bastion_public_eip" {
  value = module.sonarqube.sonarqube_bastion_public_eip
}

output "sonarqube_private_ip" {
  value = module.sonarqube.sonarqube_private_ip
}
