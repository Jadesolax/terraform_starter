ssh-keygen -t rsa -b 4096 -f /Users/jade/devops/teachings/terra/test/deployer-key

terraform plan

terraform apply

1. VPC (Virtual Private Cloud)
Resource: aws_vpc.main
Description: Created a VPC with a CIDR block of 10.0.0.0/16 to host the subnets, instances, and other resources.

2. Subnets
Frontend Subnet
Resource: aws_subnet.frontend
Description: Created a frontend subnet with a CIDR block of 10.0.1.0/24 within the VPC.

Backend Subnet
Resource: aws_subnet.backend
Description: Created a backend subnet with a CIDR block of 10.0.2.0/24 within the VPC.

3. Internet Gateway (IGW)
Resource: aws_internet_gateway.igw
Description: Created an IGW to allow instances in the VPC to access the internet.

4. Route Table and Associations
Route Table
Resource: aws_route_table.public
Description: Created a public route table associated with the VPC to direct internet traffic through the IGW.
Route Table Associations
Resources: aws_route_table_association.frontend_association and aws_route_table_association.backend_association
Description: Associated the frontend and backend subnets with the public route table.

5. Security Groups
Frontend Security Group
Resource: aws_security_group.frontend_sg
Description: Created a security group to allow inbound traffic on port 3000 (frontend service) and port 22 (SSH).
Backend Security Group
Resource: aws_security_group.backend_sg
Description: Created a security group to allow inbound traffic on port 5000 (backend service) and port 22 (SSH).

6. EC2 Instances
Frontend Instance
Resource: aws_instance.frontend
Description: Launched an EC2 instance in the frontend subnet using the t2.micro instance type and assigned a public IP.
Backend Instance
Resource: aws_instance.backend
Description: Launched an EC2 instance in the backend subnet using the t2.micro instance type and assigned a public IP.

7. Key Pair
Resource: aws_key_pair.deployer
Description: Created and imported an SSH key pair named deployer-key to securely access the EC2 instances.

8. TLS Private Key
Resource: tls_private_key.ssh
Description: Generated an SSH private key using Terraform, which was later destroyed.
