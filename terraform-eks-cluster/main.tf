data "aws_availability_zones" "available" {
}

locals {
  cluster_name = "test-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = "test-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = "test"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                  = "${local.cluster_name}-worker-group-1"
      instance_type         = "t3.small"
      autoscaling_enabled   = true
      protect_from_scale_in = false
      asg_desired_capacity  = 3
      asg_min_size          = 3
      asg_max_size          = 10
    }
  ]
}

data "template_file" "cluster_autoscaler_values" {
  template = "${file("${path.module}/cluster_autoscaler_values.tpl")}"
  vars = {
    AWS_REGION   = "${var.region}"
    CLUSTER_NAME = "${local.cluster_name}"
  }
}

resource "local_file" "cluster_autoscaler_values" {
  content  = "${data.template_file.cluster_autoscaler_values.rendered}"
  filename = "${path.module}/cluster_autoscaler_values_${local.cluster_name}.yaml"
}
