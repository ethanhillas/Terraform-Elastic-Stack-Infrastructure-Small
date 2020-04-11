# create provider
# call modules

terraform {
  required_version = ">=0.12.0"
}

provider "aws" {
  version = ">=2.57"
  region = var.region
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}

module "core" {
  source = "./core"

  # project
  project_name = var.project_name
  managed_by = var.managed_by
  region = var.region

  # core
  vpc_cidr = var.vpc_cidr
  trusted_network = var.trusted_network
  availability_zones = var.availability_zones
  public_key_file = var.public_key_file
}

module "es_cluster" {
  source = "./es_cluster"  

  # project
  project_name = var.project_name
  managed_by = var.managed_by

  # from core
  subnet_ids = module.core.subnet_ids
  trusted_network_inbound_sg_id = module.core.trusted_network_inbound_sg_id
  es_cluster_comms_sg_id = module.core.es_cluster_comms_sg_id
  outbound_internet_id = module.core.outbound_internet_id
  public_key_name = module.core.public_key_name
  
  # es_cluster
  es_ami_owner = var.es_ami_owner
  es_ami_name = var.es_ami_name
  es_instance_type = var.es_instance_type

}

module "kibana" {
  source = "./kibana"

  # project
  project_name = var.project_name
  managed_by = var.managed_by

  # from core
  subnet_ids = module.core.subnet_ids
  trusted_network_inbound_sg_id = module.core.trusted_network_inbound_sg_id
  es_cluster_comms_sg_id = module.core.es_cluster_comms_sg_id
  outbound_internet_id = module.core.outbound_internet_id
  public_key_name = module.core.public_key_name

  # kibana
  kibana_ami_owner = var.kibana_ami_owner
  kibana_ami_name = var.kibana_ami_name
  kibana_instance_type = var.kibana_instance_type
}


module "logstash" {
  source = "./logstash"

  # project
  project_name = var.project_name
  managed_by = var.managed_by

  # from core
  subnet_ids = module.core.subnet_ids
  trusted_network_inbound_sg_id = module.core.trusted_network_inbound_sg_id
  es_cluster_comms_sg_id = module.core.es_cluster_comms_sg_id
  outbound_internet_id = module.core.outbound_internet_id
  public_key_name = module.core.public_key_name

  # Logstash
  logstash_ami_owner = var.logstash_ami_owner
  logstash_ami_name = var.logstash_ami_name
  logstash_instance_type = var.logstash_instance_type

}
