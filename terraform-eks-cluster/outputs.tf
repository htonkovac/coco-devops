output "kube-connect" {
  value = "aws eks --region ${var.region} update-kubeconfig --name  ${local.cluster_name}"
}

output "cluster_name" {
  value = local.cluster_name
}

output "rds_endpoint" {
    value = module.db.this_db_instance_endpoint
}

output "elasticcache_endpoint" {
    value = aws_elasticache_replication_group.elasticache.primary_endpoint_address
}

output "backend-1-repo" {
  value = aws_ecr_repository.backend_1.repository_url
}

output "backend-2-repo" {
  value = aws_ecr_repository.backend_2.repository_url
}

output "frontend-repo" {
  value = aws_ecr_repository.frontend.repository_url
}