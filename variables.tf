## AWS Provider ##
variable "region" {
  default = "ap-southeast-2"
  description = "Region to deploy all instances"  
}

/*variable "aws_access_key" {
  description = "AWS access key for IAM user"
}

variable "aws_secret_key" {
  description = "AWS secret key for IAM user"
}*/

## Deployment Information ##
variable "project_name" {
  description = "A project name tagged to all cloud instances"
}

variable "managed_by" {
  default = "terraform"
  description = "Identifying tag for all terraform managed instances"
}

#############
## Modules ##
#############

## core ##
variable "vpc_cidr" {
  default = "192.168.100.0/24"
  description = "Subnet to be used within VPC and AZ"
}

variable "trusted_network" {
  description = "Trusted network that is allowed to access bastion host"
}

variable "availability_zones"{
  type = list(string)
  default = ["a","b","c"]
}

variable "public_key_file" {
  description = "File location of public key"
}

## es_cluster ##
variable "es_ami_owner" {
  default = "099720109477" #Canonical (Ubuntu)
  description = "Owner of ami image to use for instances"
}

variable "es_ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"
  description = "Name of ami image to use for instances"
}

variable "es_instance_type" {
  description = "AWS instance type"
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


## kibana ##
variable "kibana_ami_owner" {
  default = "099720109477" #Canonical (Ubuntu)
  description = "Owner of ami image to use for instances"
}

variable "kibana_ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"
  description = "Name of ami image to use for instances"
}

variable "kibana_instance_type" {
  description = "AWS instance type"
}


