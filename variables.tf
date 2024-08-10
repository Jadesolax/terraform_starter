# variables.tf

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-west-2"
}

variable "availability_zone" {
  description = "The AWS availability zone to create subnets in"
  type        = string
  default     = "eu-west-2a"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-07c1b39b7b3d2525d" # Ubuntu 2 AMI ID, update it based on your region
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "/Users/jade/devops/teachings/terra/test/deployer-key.pub"
}
