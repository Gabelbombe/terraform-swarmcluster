data "aws_iam_policy_document" "asg-assume-role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "asg" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.discovery-bucket}/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListObjects",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.discovery-bucket}"]

    actions = [
      "s3:ListBucket",
    ]
  }
}

data "template_file" "user-data" {
  template = "${ file( "${ path.module }/bin/user-data.sh" )}"

  vars {
    ROLE                   = "${var.role}"
    SWARM_DISCOVERY_BUCKET = "${var.discovery-bucket}"
  }
}
