output "vpc_id" {
  value = aws_vpc.milk.id
}

output "public_subnetA_id" {
  value = aws_subnet.publicA.id
}
