## project ##
variable "project_name" {
  description = "A project name tagged to all cloud instances"
}

variable "managed_by" {
  description = "Identifying tag for all terraform managed instances"
}

## logstash ##
variable "logstash_ami_owner" {
  default = "099720109477" #Canonical (Ubuntu)
  description = "Owner of ami image to use for instances"
}

variable "logstash_ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"
  description = "Name of ami image to use for instances"
}

variable "logstash_instance_type" {
  description = "AWS instance type"
}

# from core module
variable "subnet_ids" {
  description = "list of subnet id's created"
}

variable "trusted_network_inbound_sg_id" {
  description = "sg for trusted network inbound"
}

variable "es_cluster_comms_sg_id" {
  description = "sg for internal es cluster communications"
}

variable "outbound_internet_sg_id" {
  description = "sg for outbound internet traffic"
}

variable "public_key_name" {
  description = "File location of public key"
}