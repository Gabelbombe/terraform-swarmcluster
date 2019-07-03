module "vpc" {
  source = "../public-only"

  # variables
  azs            = "${ var.azs }"
  cidr           = "${ var.cidr }"
  application    = "${ var.application }"
  name           = "${ var.name }"
  provisionersrc = "${ var.provisionersrc }"
}
