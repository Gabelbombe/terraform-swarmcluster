output "autoscaling-group-name" {
  value = "${ aws_autoscaling_group.asg.name }"
}

output "instance-role-id" {
  value = "${ aws_iam_role.asg.id }"
}
