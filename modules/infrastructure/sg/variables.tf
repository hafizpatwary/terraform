variable "open-internet" {
	type 	= list(string)
	default = ["0.0.0.0/0"]
}

variable "ingress_ports" {
	type 	= list(number)
	default = [22, 80, 443]
}

variable "outbound-port" {
	type 	= number
	default = 0
}

variable "vpc_id" {
}

variable "name" {
	default = "Allow SSH, HTTP, HTTPS"
}