data "aws_ami" "ami" {
  most_recent = true

  owners = ["595879546273"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["${var.virtualization_type}"]
  }

  filter {
    name   = "name"
    values = ["CoreOS-${var.channel}-*"]
  }
}
