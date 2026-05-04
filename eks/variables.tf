variable "eks_cluster_names" {
  description = "The name of the EKS cluster."
  #type        = string
  type        = list(string)
  
}

variable "subnet_ids" {
    description = "List of subnet IDs for the EKS cluster"
    type = map(list(string))
}

variable "eks_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group."
  type        = string

}