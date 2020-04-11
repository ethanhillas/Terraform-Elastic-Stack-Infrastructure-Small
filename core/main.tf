# Create VPC
# Create subnets in availability zones
# Create internet gateway
# Create routes
# Create security groups
# Create key pair

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
    project_name = var.project_name
    managed_by = var.managed_by   
  }
}

# Subnets
resource "aws_subnet" "subnet" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  cidr_block        = cidrsubnet(var.cidr, 4, count.index)
  availability_zone = "${var.region}${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-subnet-${element(var.availability_zones, count.index)}"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-public_route_table"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

# Route table association
resource "aws_main_route_table_association" "public" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.public.id
}

# Internet gateway
resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-internet_gateway"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

# Routes
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.public.id
}


# Security Groups
resource "aws_security_group" "trusted_network_inbound" {
  name = "trusted_network_inbound"
  description = "Allow SSH and HTTP/HTTPS inbound from a trusted network"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH inbound"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.trusted_network]
  }

  ingress {
    description = "HTTP inbound"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.trusted_network]
  }

  ingress {
    description = "HTTPS inbound"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.trusted_network]
  }

  ingress {
    description = "Kibana default port"
    from_port = 5601
    to_port = 5601
    protocol = "tcp"
    cidr_blocks = [var.trusted_network]
  }
  tags = {
    Name = "${var.project_name}-sg-trusted_network_inbound"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}


resource "aws_security_group" "es_cluster_comms" {
  name = "es_cluster_comms"
  description = "Internal communications between es cluster nodes"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }

  egress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }
  tags = {
    Name = "${var.project_name}-sg-es_cluster_comms"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

resource "aws_security_group" "internet_outbound" {
  name = "internet_outbound"
  description = "All outbound communication to the internet for downloading software"
  vpc_id = aws_vpc.main.id

  egress {
    description = "HTTP outbound"
    from_port = 80
    to_port = 80 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTPS outbound"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_name}-sg-internet_outbound"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

# key pair
resource "aws_key_pair" "public_key" {
  public_key = file(var.public_key_file)
}







