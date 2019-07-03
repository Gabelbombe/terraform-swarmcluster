data "aws_ami" "ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["${var.virtualization_type}"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["${var.volume_type}"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-${var.virtualization_type}-*-${var.volume_type}"]
  }
}
