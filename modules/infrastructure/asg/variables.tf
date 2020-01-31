variable "region" {
}

variable "environment"{
}

variable "instance-type"{
	default = "t2.micro"
}

variable "pem-key" {
	default = "exercise"
}

variable "vpc_id" {
}

variable "public_subnet_id" {
}

variable "vpc_security_group_ids" {
}

variable "start_date" {
	default = "30 8 * * MON-FRI"
}

variable "stop_date" {
	default = "30 16 * * MON-FRI"
}