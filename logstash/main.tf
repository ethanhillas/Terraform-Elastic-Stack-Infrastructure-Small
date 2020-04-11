# create single node
# apply security groups

## FUTURE ##
# 2 nodes across different AZs
# ELB
# Queuing mechanism

# ami definition
data "aws_ami" "ami" {
  most_recent = true
  owners = [var.logstash_ami_owner]

  filter {
    name = "name"
    values = [var.logstash_ami_name]
  }
}

# logstash server
resource "aws_instance" "logstash_server" {

  ami = data.aws_ami.ami.id
  instance_type = var.logstash_instance_type

  subnet_id = var.subnet_ids[0]

  key_name = var.public_key_name

  vpc_security_group_ids = [
    var.trusted_network_inbound_sg_id,
    var.es_cluster_comms_sg_id,
    var.outbound_internet_id
  ]

  tags = {
    Name = "${var.project_name}-server-logstash"
    project_name = var.project_name
    managed-by = var.managed_by   
  }
}

