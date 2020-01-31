resource "aws_subnet" "public_subnet" {
	vpc_id			= var.vpc_id
	cidr_block		= "10.1.16.0/24"

	tags = {
		Name = join("-", [var.region, var.environment, "public-subnet"])
	}
}

resource "aws_subnet" "private_subnet" {
	vpc_id			= var.vpc_id
	cidr_block		= "10.1.17.0/24"

	tags = {
		Name = join("-", [var.region, var.environment, "private-subnet"])
	}
}


resource "aws_internet_gateway" "lsd-gw" {
  	vpc_id 			= var.vpc_id

  	tags = {
    	Name = "main-gw"
  	}
}

resource "aws_route_table" "lsd-route" {
  	vpc_id = var.vpc_id

  	route {
    	cidr_block = "0.0.0.0/0"
    	gateway_id = aws_internet_gateway.lsd-gw.id
  	}

  	depends_on = [
  			aws_subnet.private_subnet,
  			aws_subnet.public_subnet,
  	]

  	tags = {
    	Name = "lsd-route"
  	}
}

resource "aws_route_table_association" "public_route_association" {
    subnet_id  		= aws_subnet.public_subnet.id
    route_table_id  = aws_route_table.lsd-route.id
}