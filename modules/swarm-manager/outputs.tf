output "autoscaling-group-name" {
  value = "${ module.swarm.autoscaling-group-name }"
}

output "discovery-bucket" {
  value = "${ module.discovery-bucket.bucket }"
}

output "swarm-security-group-id" {
  value = "${ aws_security_group.swarm.id }"
}

output "instance-role-id" {
  value = "${ module.swarm.instance-role-id }"
}
