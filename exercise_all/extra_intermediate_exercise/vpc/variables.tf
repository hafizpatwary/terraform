variable "vpc-cidr-block" {
  description = "CIDR block for VPC"
  default     = "10.1.0.0/16"
}

variable "pub-snA-cidr-block" {
  description = "CIDR block for Public Subnet A"
  default     = "10.1.17.0/24"
}

variable "pub-snB-cidr-block" {
  description = "CIDR block for Public Subnet B"
  default     = "10.1.18.0/24"
}
