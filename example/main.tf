# Specify the provider and access details
provider "aws" {
  region = "us-east-1"
}

locals {
  projectName = "myproject"
}


module "dev_vpc" {
  source = "git::https://github.com/jayasimha537/terraform-aws-vpc-module.git"
  projectName = local.projectName
  environmentName = "dev"
  vpc_cidr = "10.0.0.0/16"
  public_subnets_count = 2
  private_subnets_count = 2
  public_inbound_acl_rules = var.public_inbound_acl_rules
  public_outbound_acl_rules = var.public_outbound_acl_rules
  private_inbound_acl_rules = var.private_inbound_acl_rules
  private_outbound_acl_rules = var.private_outbound_acl_rules
  enable_nat_gw = false
  default_tags = {
    "Author" = "Jayasimha"
    "kubernetes.io/cluster/${local.projectName}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks_cluster" {
  source = "../../"
  vpc_id = module.dev_vpc.vpc_id
  vpc_cidr = module.dev_vpc.vpc_cidr
  private_subnet_id_list = module.dev_vpc.private_subnet_id_list
  projectName = local.projectName
  environmentName = "dev"
  default_tags = {
    "Author" = "Jayasimha"
   }
   
   worker_nodes  = [
      {
        node_group_name = "cluster-worker-node1"
        instance_types = "t2.micro"
        desired_size   = 3
        max_size     = 3
        min_size    = 3
      },
      {
        node_group_name = "cluster-worker-node2"
        instance_types = "t2.micro"
        desired_size   = 3
        max_size     = 3
        min_size    = 3
      }
    ]
}
