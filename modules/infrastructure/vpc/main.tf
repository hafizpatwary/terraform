resource "aws_vpc" "main" {
	cidr_block		= "10.1.0.0/16"

	tags			= {
		Name = join("-", [var.region, var.environment, "vpc"])
	}
}

