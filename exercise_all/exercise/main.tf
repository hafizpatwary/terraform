provider "aws" {
	version                 = "~> 2.0"
	region                  = "eu-west-2"
	shared_credentials_file = "~/.aws/credentials"
}

resource "aws_instance" "exercise" {
	ami                     = var.ami-id
	instance_type           = var.instance_type
	key_name                = var.key_name
}

resource "aws_s3_bucket" "b" {
 	bucket             = "my-tf-test-bucket-ssh"
 	acl                = "private"

	tags = {
    	Name           = "My bucket"
    }
}