module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "rds-in-eks-cluster"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.large"
  allocated_storage = 5
  storage_encrypted = false

  name     = "helloApiDatabase"
  username = "user"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"

  vpc_security_group_ids = [aws_security_group.rds_sec_group.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  multi_az = true

  # disable backups to create DB faster
  backup_retention_period = 0


  enabled_cloudwatch_logs_exports = ["audit", "general"]

  # DB subnet group
  subnet_ids = module.vpc.private_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "final-snapshoot"

  # Database Deletion Protection
  deletion_protection = false
}


resource "aws_security_group" "rds_sec_group" {
  name_prefix = "rds-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.worker_security_group_id]
  }
}
