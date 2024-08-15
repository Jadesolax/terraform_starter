# SSH username for the instance
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}


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
  default     = "/Users/jade/devops/teachings/terra/test/Terraform_Concepts_Building_Blocks/deployer-key.pub"
}

variable "private_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "/Users/jade/devops/teachings/terra/test/Terraform_Concepts_Building_Blocks/deployer-key"
}

## THIS IS FROM FutureTech9 and IT DIDN'T WORK SO I USED MY TEMPLATE FROM THE ROOT DIRECTORY

# # variable "AWS_ACCESS_KEY" {
# #     type = string
# #     default = "AKIASMSIZOF42P2VUDSZ"
# # }

# # variable "AWS_SECRET_KEY" {}

# # AWS Region
# variable "AWS_REGION" {
#   default = "eu-west-2a"
# }

# # Security Group ID
# variable "Security_Group" {
#   type    = string
#   default = "sg-03d4f8c0cab104e00"
# }

# # AMI IDs mapped by region
# variable "AMIS" {
#   type = map(string)
#   default = {
#     us-east-1 = "ami-0f40c8f97004632f9"
#     eu-west-2a = "ami-07c1b39b7b3d2525d"
#     us-west-2 = "ami-0352d5a37fb4f603f"
#     us-west-1 = "ami-0f40c8f97004632f9"
#   }
# }

# # Path to the private key file
# variable "PATH_TO_PRIVATE_KEY" {
#   default = "/Users/jade/devops/teachings/terra/test/Terraform_Concepts_Building_Blocks/concept_key"
# }

# # Path to the public key file
# variable "PATH_TO_PUBLIC_KEY" {
#   default = "/Users/jade/devops/teachings/terra/test/Terraform_Concepts_Building_Blocks/concept_key.pub"
# }
