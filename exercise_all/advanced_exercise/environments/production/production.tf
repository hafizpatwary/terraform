variable "environment" {
}

variable "region" {
}

variable "ami_id" {
}

provider "aws" {
	version = "~> 2.0"
	region  = var.region
	shared_credentials_file = "~/.aws/credentials"
}

module "infrastructure" {
	source 		= "../modules/infrastructure"
	environment 	= var.environment
	region		= var.region
	ami_id		= var.ami_id
}


