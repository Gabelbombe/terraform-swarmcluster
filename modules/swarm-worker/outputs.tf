output "autoscaling-group-name" {
  value = "${ module.swarm.autoscaling-group-name }"
}

output "instance-role-id" {
  value = "${ module.swarm.instance-role-id }"
}
