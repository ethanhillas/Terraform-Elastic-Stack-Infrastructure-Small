## project ##
variable "project_name" {
  default = "3 Node Elastic Stack"
  description = "A project name tagged to all cloud instances"
}

variable "managed_by" {
  default = "terraform"
  description = "Identifying tag for all terraform managed instances"
}

variable "region" {
  default = "ap-southeast-2"
  description = "Region to deploy all instances"  
}

## core ##
variable "vpc_cidr" {
  default = "192.168.10.0/24"
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

