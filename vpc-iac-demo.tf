# Provider
 provider "aws" {
   
   
    profile = "botouser"
   region = "us-east-2"
 }
###MY VPC Demo Infrastructure-as-code by Ernest###
###creates VPC With a Public Subnet, Routing Tables, IGW, SG, EC2-WORDPRESS###
# Create the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My-Demo-VPC"
  }
}


# Create Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet"
  }
}

# Create a routing table for the VPC
resource "aws_route_table" "example_routing_table" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create a route for the public subnet to the internet gateway
resource "aws_route" "public_subnet_route" {
  route_table_id = aws_route_table.example_routing_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}

# Create the Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "My IGW"
  }
}

# Associate the routing table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.example_routing_table.id
}

# Create Security Group for EC2 Instances
resource "aws_security_group" "example_sg" {
  name_prefix = "example-sg-"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instances
resource "aws_instance" "example_instance_1" {
  ami           = "ami-02a9c85a3d54e4d30"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  tags = {
    Name = "tf-wordpress-webserver"
  }
    # Attach a public IP address
  associate_public_ip_address = true
}