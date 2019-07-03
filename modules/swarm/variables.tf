// Settings
variable "vpc-id" {}

variable "ami-id" {}
variable "key-name" {}
variable "instance-type" {}

variable "security-group-ids" {
  type = "list"
}

variable "subnet-ids" {
  type = "list"
}

// Instance Settings
variable "size" {
  default = 1
}

variable "volume_size" {
  default = 52
}

variable "user-data-vars" {
  type = "map"

  default = {
    foo = "bar"
  }
}

variable "role" {}
variable "discovery-bucket" {}

// Tags
variable "name" {
  description = "Name tag"
}

variable "application" {
  description = "Application tag"
}

variable "provisionersrc" {
  description = "Tag linking to the repository"
}
