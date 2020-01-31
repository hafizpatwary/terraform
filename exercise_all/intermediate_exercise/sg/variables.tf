variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22, 80, 443]
}

variable "name" {
  description = "Name of security group"
  default 	  = "SSH" 
}

variable "open-internet" {
  type        = list(string)
  description = "Internet"
  default 	  = ["0.0.0.0/0"] 
}

variable "vpc_id" {
  description = "VPC ID from the newly created vpc"
}

variable "outbound-port" {
  description = "VPC ID from the newly created vpc"
  default     = 0
}

