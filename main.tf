module "vpc" {
  source       = "./vpc"
    vpc_cidr     = var.vpc_cidr
    pubnet_names = var.pubnet_names
    pubnet_specs = var.pubnet_specs
    prinet_names = var.prinet_names
    prinet_specs = var.prinet_specs
    prinet_az    = var.prinet_az
    prinet_desc  = var.prinet_desc
}

module "roles" {
  source = "./roles"
  
}

module "eks" {
  source = "./eks"
    eks_cluster_names   = var.eks_cluster_names
    eks_node_group_names = var.eks_node_group_names
    eks_version         = var.eks_version
    subnet_ids          = local.subnet_ids
    node_subnet_ids     = local.node_subnet_ids

}


locals {
  subnet_ids = {
    dev_eks_cluster = [
      module.vpc.prisub_demo_prinetaz1_1_id,
      module.vpc.prisub_demo_prinetaz2_1_id
    ]
    prd_eks_cluster = [
      module.vpc.prisub_demo_prinetaz1_2_id,
      module.vpc.prisub_demo_prinetaz2_2_id
    ]
  }
}

locals {
  node_subnet_ids = {
    dev_eks_node = [
      module.vpc.prisub_demo_prinetaz1_1_id,
      module.vpc.prisub_demo_prinetaz2_1_id
    ]
    prd_eks_node = [
      module.vpc.prisub_demo_prinetaz1_2_id,
      module.vpc.prisub_demo_prinetaz2_2_id
    ]
  }
}
