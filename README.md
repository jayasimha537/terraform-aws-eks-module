# terraform-aws-eks-module
EKS with Dynamic node groups

# Sample Usage
```sh
$ git clone https://github.com/jayasimha537/terraform-aws-eks-module.git
$ cd terraform-aws-eks-module/example/
$ terraform plan  -var-file="nacl_rules.tfvars"
```

# Creating VPC 
Used https://github.com/jayasimha537/terraform-aws-vpc-module.git Module for this. Please check the example code
EKS required below tags for Subnets
```sh

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
```
# Creating EKS Cluster
```Sh
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
```

