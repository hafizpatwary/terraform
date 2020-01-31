variable "ubuntu-ami" {
  description   = "Ubunutu 18.04"
  default       = "ami-0be057a22c63962cb"
}

variable "instance-type" {
  description   = "Specific RAM, CPU"
  default       = "t2.micro"
}

variable "pem-key" {
  description   = "Priavate Key for ec2"
  default       = "exercise"
}

variable "subnet_id" {
  description   = "Specific subnet"
}

variable "vpc_security_group_ids" {
  description   = "Security group"
}

variable "associate_public_ip_address" {
  description   = "Assigning public ip address to EC2 instance"
  default       = true
}

#variable "tags" {
#  description   = "Assigning public ip address to EC2 instance"
#  default       = {
#    Name = "Oreo"
#  }
#}