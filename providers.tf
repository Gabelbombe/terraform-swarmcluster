provider "aws" {
  allowed_account_ids = ["${var.account_id}"]
  max_retries         = 5
  region              = "${var.region}"
}
