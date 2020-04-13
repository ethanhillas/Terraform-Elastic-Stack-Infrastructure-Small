# VPC
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.subnet.*.id
}

output "trusted_network_inbound_sg_id" {
  value = aws_security_group.trusted_network_inbound.id
}

output "es_cluster_comms_sg_id" {
  value = aws_security_group.es_cluster_comms.id
}

output "outbound_internet_sg_id" {
  value = aws_security_group.internet_outbound.id
}

output "public_key_name" {
  value = aws_key_pair.public_key.key_name
}







