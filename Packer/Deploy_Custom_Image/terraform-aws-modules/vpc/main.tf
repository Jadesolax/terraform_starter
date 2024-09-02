# Create VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr
  tags = var.tags
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { "Name" = format("%s-public-%d", var.name, count.index + 1) }
  )
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    var.tags,
    { "Name" = format("%s-private-%d", var.name, count.index + 1) }
  )
}

# Optional NAT Gateways
resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? length(aws_subnet.public) : 0
  allocation_id = aws_eip.this[count.index].id
  subnet_id = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    var.tags,
    { "Name" = format("%s-nat-gateway-%d", var.name, count.index + 1) }
  )
}

# Create EIP for NAT Gateway
resource "aws_eip" "this" {
  count  = var.enable_nat_gateway ? length(aws_subnet.public) : 0
  domain = "vpc"
}

# Create a Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    { "Name" = "${var.name}-private" }
  )
}

# Route Table Associations for Private Subnets
resource "aws_route_table_association" "private" {
  count = var.enable_nat_gateway ? length(aws_subnet.private) : 0
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
