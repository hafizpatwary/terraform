output "public_subnet_id" {
	value 		= aws_subnet.public_subnet.id
	description = "PublicSubnet ID for main VPC"
}

output "private_subnet_id" {
	value = aws_subnet.private_subnet.id
	description = "PrivaeSubnet ID for main VPC"
}