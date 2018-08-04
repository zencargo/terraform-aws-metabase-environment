output "eb_instance_profile_role_name" {
  value       = "${module.elastic_beanstalk_environment.ec2_instance_profile_role_name}"
  description = "Instance IAM role name for the EB environment"
}

output "eb_dns_name" {
  value       = "${module.elastic_beanstalk_environment.elb_dns_name}"
  description = "EB technical host"
}

output "eb_zone_id" {
  value       = "${module.elastic_beanstalk_environment.elb_zone_id}"
  description = "EB zone id"
}

output "eb_host" {
  value       = "${module.elastic_beanstalk_environment.host}"
  description = "DNS hostname"
}

output "eb_name" {
  value       = "${module.elastic_beanstalk_environment.name}"
  description = "Name of the EB environment"
}

output "eb_security_group_id" {
  value       = "${module.elastic_beanstalk_environment.security_group_id}"
  description = "EB security group id"
}
