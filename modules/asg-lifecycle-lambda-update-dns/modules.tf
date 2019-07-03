module "asg-lifecycle" {
  source = "../asg-lifecycle-lambda"

  name           = "${ var.name }"
  application    = "${ var.application }"
  provisionersrc = "${ var.provisionersrc }"

  # variables
  group_names = "${ var.group_names }"

  lambda = {
    filename = "${data.archive_file.lambda_zip.output_path}"
    handler  = "handler.handler_update_dns"
    runtime  = "python2.7"                                   // Py2.7 has EOL January 1st 2020, THIS NEEDS TO BE UPDATED!!!
  }

  policy            = "${data.aws_iam_policy_document.notify.json}"
  delay_termination = "${var.record["ttl"] + 120}"

  env_vars = {
    ZONE_ID     = "${var.zone_id}"
    RECORD_TTL  = "${var.record["ttl"]}"
    RECORD_NAME = "${var.record["name"]}"
    RECORD_TYPE = "${var.record["type"]}"
  }
}
