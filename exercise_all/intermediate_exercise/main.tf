provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_vpc" {
  source = "./vpc"
}

module "aws_webserver_sg" {
  source        = "./sg"
  name          = "WebServerSG"
  vpc_id        = module.aws_vpc.vpc_id
}

module "webserver_node" {
  source                 = "./ec2"
  subnet_id              = module.aws_vpc.public_subnetA_id
  vpc_security_group_ids = module.aws_webserver_sg.vpc_security_group_ids
  #tags = {
  #  Name = "WebServer_Node"
  #}
  associate_public_ip_address = true
}
