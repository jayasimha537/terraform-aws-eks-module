resource "aws_eks_node_group" "cluster-worker-node" {
  count = length(var.worker_nodes)
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.worker_nodes[count.index]["node_group_name"]
  node_role_arn   = aws_iam_role.cluster-worker-node.arn
  subnet_ids      = var.private_subnet_id_list
  instance_types = [var.worker_nodes[count.index]["instance_types"]]
  scaling_config {
    desired_size = var.worker_nodes[count.index]["desired_size"]
    max_size     = var.worker_nodes[count.index]["max_size"]
    min_size     = var.worker_nodes[count.index]["min_size"]
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEC2ContainerRegistryReadOnly,
  ]
  tags = {
    Name = var.worker_nodes[count.index]["node_group_name"]
  }
}

#resource "aws_eks_node_group" "cluster-worker-node1" {
#  cluster_name    = aws_eks_cluster.eks_cluster.name
#  node_group_name = "cluster-worker-node1"
#  node_role_arn   = aws_iam_role.cluster-worker-node.arn
#  subnet_ids      = var.private_subnet_id_list
#  instance_types = ["t2.micro"]
#
#  scaling_config {
#    desired_size = 1
#    max_size     = 1
#    min_size     = 1
#  }
#
#  depends_on = [
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEC2ContainerRegistryReadOnly,
#  ]
#}
#
#
#resource "aws_eks_node_group" "cluster-worker-node2" {
#  cluster_name    = aws_eks_cluster.eks_cluster.name
#  node_group_name = "cluster-worker-node2"
#  node_role_arn   = aws_iam_role.cluster-worker-node.arn
#  subnet_ids      = var.private_subnet_id_list
#  instance_types = ["t2.micro"]
#  scaling_config {
#    desired_size = 1
#    max_size     = 1
#    min_size     = 1
#  }
#
#  depends_on = [
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.cluster-worker-node-AmazonEC2ContainerRegistryReadOnly,
#  ]
#}
