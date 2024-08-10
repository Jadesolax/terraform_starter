# outputs.tf

output "frontend_instance_id" {
  description = "The ID of the frontend EC2 instance"
  value       = aws_instance.frontend.id
}

output "backend_instance_id" {
  description = "The ID of the backend EC2 instance"
  value       = aws_instance.backend.id
}

output "frontend_subnet_id" {
  description = "The ID of the frontend subnet"
  value       = aws_subnet.frontend.id
}

output "backend_subnet_id" {
  description = "The ID of the backend subnet"
  value       = aws_subnet.backend.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
