output "vpc_id" {
	description = "VPC id for a specific region"
	value		= aws_vpc.main.id
}