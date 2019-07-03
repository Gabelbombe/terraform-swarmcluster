#########################
# Container Instances
#########################

# An IAM instance profile we can attach to an EC2 instance
resource "aws_iam_instance_profile" "asg" {
  name = "${var.name}"
  role = "${aws_iam_role.asg.name}"

  # aws_launch_configuration.asg sets create_before_destroy to true, which means every resource it depends on,
  # including this one, must also set the create_before_destroy flag to true, or you'll get a cyclic dependency error.
  lifecycle {
    create_before_destroy = true
  }
}

# An IAM role that we attach to the EC2 Instances in ECS.
resource "aws_iam_role" "asg" {
  name               = "${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.asg-assume-role.json}"

  # aws_iam_instance_profile.asg sets create_before_destroy to true, which means every resource it depends on,
  # including this one, must also set the create_before_destroy flag to true, or you'll get a cyclic dependency error.
  lifecycle {
    create_before_destroy = true
  }
}

// Add user supplied permissions, if any have been set
resource "aws_iam_role_policy" "asg" {
  name   = "${ var.name }-asg"
  role   = "${aws_iam_role.asg.id}"
  policy = "${data.aws_iam_policy_document.asg.json}"
}
