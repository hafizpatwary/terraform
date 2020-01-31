provider "aws" {
	version					= "~> 2.0"
	region					= "eu-west-2"
	shared_credentials_file = "~/.aws/credentials"
}

resource "aws_vpc" "azure" {
	cidr_block				= "10.0.0.0/16"

	tags = {
		Name = "azure"
	}
}

resource "aws_internet_gateway" "azure-gw" {
  	vpc_id 			= aws_vpc.azure.id

  	tags = {
    	Name = "azure-gw"
  	}
}

resource "aws_subnet" "public" {
  	vpc_id     				= aws_vpc.azure.id
  	cidr_block 				= "10.0.16.0/24"
  	availability_zone		= "eu-west-2c"
  	map_public_ip_on_launch = true

  	depends_on 			= [aws_vpc.azure]

  	tags = {
    	Name = "west-2c"
  	}
}

resource "aws_subnet" "private" {
  	vpc_id     			= aws_vpc.azure.id
  	cidr_block 			= "10.0.17.0/24"
  	availability_zone	= "eu-west-2a"

  	depends_on 			= [aws_vpc.azure]

  	tags = {
    	Name = "west-2a"
  	}
}

resource "aws_route_table" "azure-route" {
  	vpc_id = aws_vpc.azure.id

  	route {
    	cidr_block = "0.0.0.0/0"
    	gateway_id = aws_internet_gateway.azure-gw.id
  	}

  	depends_on = [
  			aws_subnet.private,
  			aws_subnet.public,
 			aws_vpc.azure
  	]

  	tags = {
    	Name = "azure-route"
  	}
}

resource "aws_route_table_association" "public_route_association" {
    subnet_id  		= aws_subnet.public.id
    route_table_id  = aws_route_table.azure-route.id
}

resource "aws_security_group" "azure-ec2-sg" {
    name            =   "SSH, HTTP, HTTPS"
    vpc_id          =   aws_vpc.azure.id

    #SSH

    ingress {
        from_port   =   22
        protocol    =   "tcp"
        to_port     =   22
        cidr_blocks =   ["0.0.0.0/0"]
    }

    #HTTP

    ingress {
        from_port   =   80
        protocol    =   "tcp"
        to_port     =   80
        cidr_blocks =   ["0.0.0.0/0"]
    }

    #HTTPS

    ingress {
        from_port   =   443
        protocol    =   "tcp"
        to_port     =   443
        cidr_blocks =   ["0.0.0.0/0"]
    }

    egress {
        from_port   =   0
        protocol    =   "-1"
        to_port     =   0
        cidr_blocks =   ["0.0.0.0/0"]
    }

}

resource "aws_instance" "azure-ec2" {
  ami               = "ami-0be057a22c63962cb"
  instance_type     = "t2.micro"
  key_name          = "exercise"
  subnet_id         = aws_subnet.public.id
  vpc_security_group_ids  = [aws_security_group.azure-ec2-sg.id]
}

output "azure-ec2-ip" {
  	description = "List of public IP addresses assigned to the instances, if applicable"
  	value       = aws_instance.azure-ec2.*.public_ip
}

