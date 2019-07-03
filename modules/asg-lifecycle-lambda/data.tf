data "aws_iam_policy_document" "notify_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

// Add default permissions to allow lambda to Interrogate Autoscaling Group Instances
data "aws_iam_policy_document" "notify" {
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "ec2:DescribeInstances",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy_document" "topic_hook" {
  statement {
    actions = ["sns:publish"]

    principals {
      type        = "Service"
      identifiers = ["${aws_sns_topic.notify.arn}"]
    }
  }
}

data "aws_iam_policy_document" "subscription_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["autoscaling.amazonaws.com"]
    }
  }
}
