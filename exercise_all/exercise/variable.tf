variable "ami-id" {
	description		= "Ubuntu 18.04"
	default			= "ami-0be057a22c63962cb"
}

variable "instance_type" {
	default			= "t2.micro"
}

variable "key_name" {
	default			= "exercise"
}