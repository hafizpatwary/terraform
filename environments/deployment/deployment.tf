variable "environment" {
}

variable "region" {
}


provider "aws" {
	region 					= var.region
	version					= "~> 2.7"
	shared_credentials_file = "~/.aws/credentials"
}

module "infrastucture" {
	source 		= "../../modules/infrastructure"
	region 		= var.region
	environment	= var.environment
}

