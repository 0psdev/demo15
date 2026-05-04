resource "aws_eks_cluster" "eks_cluster_names" {
  for_each = toset(var.eks_cluster_names)
  name = each.value

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version

  bootstrap_self_managed_addons = false

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false

    subnet_ids = var.subnet_ids[each.value]

    #subnet_ids = [
      #aws_subnet.prisub_demo_prinetaz1-2.id,
      #aws_subnet.prisub_demo_prinetaz2-2.id,
    #]
  }
}

resource "aws_eks_node_group" "eks_node_group_name" {
  cluster_name    = aws_eks_cluster.eks_cluster_name.name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  node_group_name = var.eks_node_group_name
  subnet_ids      = [
    aws_subnet.prisub_demo_prinetaz1-2.id,
    aws_subnet.prisub_demo_prinetaz2-2.id,
  ]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  disk_size      = 20
}