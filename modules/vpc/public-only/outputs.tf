output "gateway-id" {
  value = "${ aws_internet_gateway.main.id }"
}

output "id" {
  value = "${ aws_vpc.main.id }"
}

output "subnet-ids-public" {
  value = ["${ aws_subnet.public.*.id }"]
}
