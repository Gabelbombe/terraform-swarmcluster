output "gateway-id" {
  value = "${ module.vpc.gateway-id }"
}

output "id" {
  value = "${ module.vpc.id }"
}

output "subnet-ids-public" {
  value = ["${ module.vpc.subnet-ids-public }"]
}

output "route-table-id" {
  value = "${ aws_route_table.private.id }"
}

output "subnet-ids-private" {
  value = ["${ aws_subnet.private.*.id }"]
}
