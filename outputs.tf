output "vpc" {
  value = module.core.vpc_id
}

output "subnets" {
  value = module.core.subnet_ids
}

output "Logstash-server" {
  value = format("SSH: %s", module.logstash.logstash_server.public_dns)
}


output "Kibana-server" {
  value = format("SSH: %s\nKibana URL: http://%s:5601", module.kibana.kibana_server.public_dns, module.kibana.kibana_server.public_dns)
}

output "Elasticsearch-server-1" {
  value = format("SSH: %s", module.es_cluster.es_servers[0].public_dns)
}

output "Elasticsearch-server-2" {
  value = format("SSH: %s", module.es_cluster.es_servers[1].public_dns)
}

output "Elasticsearch-server-3" {
  value = format("SSH: %s", module.es_cluster.es_servers[2].public_dns)
}
