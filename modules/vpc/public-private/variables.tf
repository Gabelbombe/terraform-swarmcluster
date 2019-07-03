// Settings
variable "azs" {
  description = "List of availability zones"
  type        = "list"
}

variable "cidr" {
  description = "CIDR subnet range"
}

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
