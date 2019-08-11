output "kubectl_connect_to_cluster_command" {
  value = "aws eks --region ${var.region} update-kubeconfig --name  ${local.cluster_name}"
}

output "rds_endpoint" {
    value = module.db.this_db_instance_endpoint
}

output "elasticcache_endpoint" {
    value = aws_elasticache_replication_group.elasticache.primary_endpoint_address
}