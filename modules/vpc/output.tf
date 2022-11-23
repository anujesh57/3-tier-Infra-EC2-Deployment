output "subnetid" {
  value = aws_subnet.main-2.id
}
output "datasubnet1"{

    value = aws_subnet.databasesub-1.id
}
output "datasubnet2" {
    value = aws_subnet.databasesub-2.id
}
output "sgid" {
  value = aws_security_group.websg.id
}
output "vpcid" {
  value = aws_vpc.main.id
}
output "websubnet1" {
  value = aws_subnet.main-1.id
}
output "websubnet2" {
  value = aws_subnet.main-2.id
}