module "vpc" {
	source 		= "./vpc"
	environment = var.environment
	region		= var.region
}

module "subnet" {
	source 		= "./subnets"
	vpc_id 		= module.vpc.vpc_id
	environment = var.environment
	region		= var.region
}

module "security_group" {
	source 		= "./sg"
	vpc_id 		= module.vpc.vpc_id
}

module "auto_scaling_group" {
	source 					= "./asg"
	vpc_id 					= module.vpc.vpc_id
	environment 			= var.environment
	region					= var.region
	public_subnet_id 		= module.subnet.public_subnet_id
	vpc_security_group_ids 	= module.security_group.security_group_id
}
