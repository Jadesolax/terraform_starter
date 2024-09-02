# Variable for Create Instance Module
variable "public_key_path" {
  description = "Public key path"
  default = "/Users/jade/devops/teachings/terra/test/Packer/Deploy_Custom_Image/custom_ami_deployment/levelup_key.pub"
}

variable "ENVIRONMENT" {
    type    = string
    default = "development"
}

variable "AMI_ID" {
    type    = string
    default = "ami-073f375bc918edc34"
}

variable "AWS_REGION" {
default = "us-east-2"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}