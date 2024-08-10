terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 0.12"
}

# Specify the provider
provider "aws" {
  region = var.aws_region
}

# Define the AWS Key Pair resource
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"  # Replace with your actual key name
  public_key = file(var.public_key_path)  # This file should exist in your project
}

# Import the existing Key Pair
import {
  to = aws_key_pair.deployer
  id = "deployer-key"  # The name of the key pair in AWS
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main-VPC"
  }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main-IGW"
  }
}

# Create a public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# Associate the frontend subnet with the public route table
resource "aws_route_table_association" "frontend_association" {
  subnet_id      = aws_subnet.frontend.id
  route_table_id = aws_route_table.public.id
}

# Associate the backend subnet with the public route table
resource "aws_route_table_association" "backend_association" {
  subnet_id      = aws_subnet.backend.id
  route_table_id = aws_route_table.public.id
}

# Create a frontend subnet
resource "aws_subnet" "frontend" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "Frontend-Subnet"
  }
}

# Create a backend subnet
resource "aws_subnet" "backend" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "Backend-Subnet"
  }
}

# Create a security group for the frontend
resource "aws_security_group" "frontend_sg" {
  vpc_id = aws_vpc.main.id
  name   = "frontend_sg"

  ingress {
    description = "Allow access to frontend on port 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Frontend-SG"
  }
}

# Create a security group for the backend
resource "aws_security_group" "backend_sg" {
  vpc_id = aws_vpc.main.id
  name   = "backend_sg"

  ingress {
    description = "Allow access to backend on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Backend-SG"
  }
}

# Read the SSH public key file
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a frontend EC2 instance
resource "aws_instance" "frontend" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.frontend.id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  
  tags = {
    Name = "Frontend-Instance"
  }
}

# Create a backend EC2 instance
resource "aws_instance" "backend" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.backend.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Backend-Instance"
  }
}
