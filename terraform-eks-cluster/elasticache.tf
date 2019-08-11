resource "aws_elasticache_replication_group" "elasticache" {
  automatic_failover_enabled    = true
  replication_group_id          = "tf-rep-group-1"
  replication_group_description = "test description"
  node_type                     = "cache.m4.large"
  number_cache_clusters         = 2
  apply_immediately             = true
  subnet_group_name             = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids            = [aws_security_group.elasticache_sec_group.id]
}

resource "aws_security_group" "elasticache_sec_group" {
  name_prefix = "elasticache-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [module.eks.worker_security_group_id]
  }
}
resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = module.vpc.private_subnets
}
