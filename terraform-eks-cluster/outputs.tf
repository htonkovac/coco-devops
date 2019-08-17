output "kube-connect" {
  value = "aws eks --region ${var.region} update-kubeconfig --name  ${local.cluster_name}"
}

output "cluster_name" {
  value = local.cluster_name
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

output "rds_dbname" {
  value = module.db.this_db_instance_name
}

output "rds_username" {
  value = module.db.this_db_instance_username
}
output "rds_password" {
  value = module.db.this_db_instance_password
}
output "rds_address" { # url-to-database.aws.com
  value = module.db.this_db_instance_address
}
output "rds_endpoint" { # endpoint is equal to adress + port i.e. url-to-database.aws.com:PORT
  value = module.db.this_db_instance_endpoint
}