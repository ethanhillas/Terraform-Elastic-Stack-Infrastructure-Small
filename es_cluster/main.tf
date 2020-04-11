# Create 3 nodes across 3 availability zones
# Apply security groups

# ami definition
data "aws_ami" "ami" {
  most_recent = true
  owners = [var.es_ami_owner]

  filter {
    name = "name"
    values = [var.es_ami_name]
  }
}

# 3 x server instances
resource "aws_instance" "es_servers" {
  count = 3

  ami = data.aws_ami.ami.id
  instance_type = var.es_instance_type

  subnet_id = element(var.subnet_ids.*, count.index)

  key_name = var.public_key_name

  vpc_security_group_ids = [
    var.trusted_network_inbound_sg_id,
    var.es_cluster_comms_sg_id,
    var.outbound_internet_id
  ]

  tags = {
    Name = "${var.project_name}-es-server-${count.index}"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

